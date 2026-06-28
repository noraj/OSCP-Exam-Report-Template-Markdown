local function read_file(path)
  local file = io.open(path, "rb")
  if not file then
    return nil
  end

  local contents = file:read("*all")
  file:close()
  return contents
end

local function include_paths(filename)
  local paths = {}

  if PANDOC_STATE and PANDOC_STATE.input_files and #PANDOC_STATE.input_files > 0 then
    local input_file = PANDOC_STATE.input_files[1]
    if input_file ~= "-" then
      local input_dir = pandoc.path.directory(input_file)
      paths[#paths + 1] = pandoc.path.join({ input_dir, filename })
    end
  end

  paths[#paths + 1] = filename
  return paths
end

function CodeBlock(block)
  local filename = block.attributes.include
  if not filename then
    return nil
  end

  for _, path in ipairs(include_paths(filename)) do
    local contents = read_file(path)
    if contents then
      block.text = contents
      block.attributes.include = nil
      return block
    end
  end

  error("Could not include code file: " .. filename)
end
