local function read_file(path)
  local file = io.open(path, "rb")
  if not file then
    return nil
  end

  local contents = file:read("*all")
  file:close()
  return contents
end

local function file_exists(path)
  local file = io.open(path, "rb")
  if not file then
    return false
  end

  file:close()
  return true
end

local function is_external(target)
  return target:match("^[%a][%w+.-]*:") or target:match("^//") or target:match("^#")
end

local function resolve_path(base_dir, target)
  if pandoc.path.is_absolute(target) then
    return pandoc.path.normalize(target)
  end

  return pandoc.path.normalize(pandoc.path.join({ base_dir, target }))
end

local function is_include_link(link)
  if link.attributes.include == "true" then
    return true
  end

  for _, class in ipairs(link.classes) do
    if class == "include" then
      return true
    end
  end

  return not is_external(link.target) and link.target:lower():match("%.md$") ~= nil
end

local function input_directory()
  if PANDOC_STATE and PANDOC_STATE.input_files and #PANDOC_STATE.input_files > 0 then
    local input_file = PANDOC_STATE.input_files[1]
    if input_file ~= "-" then
      return pandoc.path.directory(input_file)
    end
  end

  return "."
end

local include_file
local include_sequence = 0

local function namespace_document(document, path)
  include_sequence = include_sequence + 1

  local name = pandoc.path.filename(path):gsub("%.[^.]+$", "")
  name = name:lower():gsub("[^%w]+", "-"):gsub("^-", ""):gsub("-$", "")
  if name == "" then
    name = "chapter"
  end

  local prefix = name .. "-" .. include_sequence .. "-"
  local identifiers = {}

  local function prefix_identifier(element)
    if element.identifier and element.identifier ~= "" then
      local old_identifier = element.identifier
      element.identifier = prefix .. old_identifier
      identifiers[old_identifier] = element.identifier
    end
    return element
  end

  document = document:walk({
    Code = prefix_identifier,
    CodeBlock = prefix_identifier,
    Div = prefix_identifier,
    Figure = prefix_identifier,
    Header = prefix_identifier,
    Image = prefix_identifier,
    Link = prefix_identifier,
    Span = prefix_identifier,
    Table = prefix_identifier
  })

  return document:walk({
    Link = function(link)
      local identifier = link.target:match("^#(.+)$")
      if identifier and identifiers[identifier] then
        link.target = "#" .. identifiers[identifier]
      end
      return link
    end
  })
end

local function expand_document(document, base_dir, stack, rebase_resources)
  return document:walk({
    Image = function(image)
      -- Included chapter resources are searched relative to that chapter's directory.
      if rebase_resources and not is_external(image.src) then
        local chapter_path = resolve_path(base_dir, image.src)
        if file_exists(chapter_path) then
          image.src = chapter_path
        end
      end
      return image
    end,

    Link = function(link)
      if rebase_resources and not is_external(link.target) then
        link.target = resolve_path(base_dir, link.target)
      end
      return link
    end,

    CodeBlock = function(block)
      local target = block.attributes.include
      if rebase_resources and target and not is_external(target) then
        block.attributes.include = resolve_path(base_dir, target)
      end
      return block
    end,

    Para = function(paragraph)
      local links = {}
      local expect_link = true

      for _, inline in ipairs(paragraph.content) do
        if expect_link then
          if inline.tag ~= "Link" or not is_include_link(inline) then
            return nil
          end
          links[#links + 1] = inline
        elseif inline.tag ~= "SoftBreak" and inline.tag ~= "LineBreak" then
          return nil
        end

        expect_link = not expect_link
      end

      if #links == 0 or expect_link then
        return nil
      end

      local blocks = {}
      for _, link in ipairs(links) do
        if is_external(link.target) then
          error("Markdown include must reference a local file: " .. link.target)
        end

        -- Link callbacks run before Para callbacks during a Pandoc walk. Links
        -- in included documents have therefore already been rebased above.
        local include_path = link.target
        if not rebase_resources then
          include_path = resolve_path(base_dir, include_path)
        end

        for _, block in ipairs(include_file(include_path, stack)) do
          blocks[#blocks + 1] = block
        end
      end

      return blocks
    end
  })
end

include_file = function(path, stack)
  if stack[path] then
    error("Circular Markdown include: " .. path)
  end

  local contents = read_file(path)
  if not contents then
    error("Could not include Markdown file: " .. path)
  end

  stack[path] = true
  local document = pandoc.read(contents, "markdown+yaml_metadata_block+raw_html")
  document = namespace_document(document, path)
  document = expand_document(document, pandoc.path.directory(path), stack, true)
  stack[path] = nil
  return document.blocks
end

function Pandoc(document)
  return expand_document(document, input_directory(), {}, false)
end
