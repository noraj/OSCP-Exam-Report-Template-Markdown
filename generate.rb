#!/usr/bin/env ruby

puts "---[ Offensive Security Exam Report Generator ]---"

# Default options
# Uncommment and set your own default options to not get prompted each time
options = {
  # template: 0,
  # osid: 'OS-####',
  # style: 'breezedark',
  # view: true,
  # archive: true,
  # extra_file: false
}

require 'optparse'
OptionParser.new do |opts|
  opts.banner = "Usage: generate.rb [options]"
  opts.on("-t", "--template ID", "Template ID") { |o| options[:template] = o }
  opts.on("-i", "--os-id ID",    "Offensive Security student ID (OS-ID)") { |o| options[:osid] = o }
  opts.on("-s", "--style STYLE", "Code highlight style (or 'd' for default which is breezedark)") { |o| options[:style] = o != 'd' ? o : false  }
  opts.on("-v", "--view Y/N",    "View PDF after generating with the OS default PDF viewer") { |o| options[:view] = o.downcase == 'y' }
  opts.on("-a", "--archive Y/N", "Create an archive") { |o| options[:archive] = o.downcase == 'y' }
  opts.on("-e", "--extra FILE",  "Extra file(s) to include in archive (or 'n' for none)") { |o| options[:extra_file] = o != 'n' ? o : false }
end.parse!

templates = []
Dir.entries("src").sort.each do |f|
  if f.end_with?(".md")
    templates.append( {
      exam: f[0..3],
      name: f[5..-4].gsub('_', ' '),
      path: "src/#{f}"
    })
  end
end

# Choose template
if options.key?(:template) and options[:template].to_i.between?(0, templates.length())
  template = options[:template].to_i
  puts "Chosen template: #{templates[template][:name]}"
  src = templates[template][:path]
  exam = templates[template][:exam]
else
  puts "Available templates;"
  templates.each_with_index do |t,i|
    puts "#{i}. [#{t[:exam]}] #{t[:name]}"
  end
  print 'Choose a template: '
  template = gets.chomp.to_i
  src = templates[template][:path]
  exam = templates[template][:exam]
end

# Enter your OS id
if options.key?(:osid)
  osid = (options[:osid].start_with?("OS-") ? "" : "OS-") + options[:osid]
  puts "OS-ID: #{osid}"
else
  print 'Enter your OS id: OS-'
  osid = 'OS-' + gets.chomp
end

# Choose syntax highlight style
style = 'breezedark'
styles = %x(pandoc --list-highlight-styles).split("\n")
if options.key?(:style) and (!options[:style] or options[:style].downcase == 'd')
  # Default style according to argument
  puts "Style: #{style}"
elsif options.key?(:style) and options[:style] == options[:style].to_i.to_s and options[:style].to_i.between?(0, styles.length())
  # Argument set style by integer
  style = styles[options[:style].to_i]
  puts "Style: #{style}"
elsif options.key?(:style) and styles.include?(options[:style])
  # Argument set style by string
  style = options[:style]
  puts "Style: #{style}"
else
  puts "Available highlight styles;"
  styles.each_with_index do |s,i|
    puts "#{i}. #{s}"
  end
  print "Choose syntax highlight style [#{style}]: "
  choice = gets.chomp
  style = styles[choice.to_i] unless choice.empty?
end

view = true
if options.key?(:view)
  view = options[:view].to_s.downcase == "true"
else
  print 'Do you want to view the report after generating? [Y/n]: '
  choice = gets.chomp
  if choice.downcase == 'n'
    view = false
  end
end

archive = true
if options.key?(:archive)
  archive = options[:archive].to_s.downcase == "true"
else
  print 'Do you want to archive the report? [Y/n]: '
  choice = gets.chomp
  if choice.downcase == 'n'
    archive = false
  end
end

extra_file = false
if archive
  # Optional lab report
  if options.key?(:extra_file)
    if !options[:extra_file] or options[:extra_file].downcase == 'n'
      nil
    else
      extra_file = options[:extra_file]
      puts "Extra file(s): #{extra_file}"
    end
  else
    print 'Do you want to add extra files to the archive? [y/N]: '
    choice = gets.chomp
    if choice.downcase == 'y'
      print 'Write the path to the file(s): '
      extra_file = gets.chomp
    end
  end
end

# We assume that the template and output directory is always relative to the
# script location and not where you call it, this makes it easier to set up an
# alias. If this is wrong and you want relative paths from current directory,
# simply remove `File.dirname(__FILE__)` below and when generating.
filename = "#{exam}-#{osid}-Exam-Report"
src_path = File.expand_path(src, File.dirname(__FILE__))
pdf_path = File.expand_path("output/#{filename}.pdf", File.dirname(__FILE__))
archive_path = File.expand_path("output/#{filename}.7z", File.dirname(__FILE__))

# Generating report
print 'Generating report...'
%x(cd '#{File.dirname(__FILE__)}' &&
  pandoc #{src_path} -o #{pdf_path} \
  --from markdown+yaml_metadata_block+raw_html \
  --template eisvogel \
  --table-of-contents \
  --toc-depth 6 \
  --number-sections \
  --top-level-division=chapter \
  --highlight-style #{style} \
  --metadata date='#{Time.now.strftime("%Y-%m-%d")}'
)
puts "done"

if view
  # Opening viewer in new process
  print 'Viewing PDF...'
  viewer = fork do
    exec "open #{pdf_path}"
  end
  Process.detach(viewer)
  puts "done"
end

if archive
  # Removing old archive
  print 'Cleaning archive...'
  `rm \
    #{archive_path} \
    2>/dev/null
  `
  puts "done"

  # Generating archive
  print 'Generating archive...'
  %x(7z a #{archive_path} \
    #{pdf_path}
  )
  puts "done"

  # Updating archive
  if extra_file
    # For additional files we're assuming relative paths
    # else we need to split and expand individually
    print 'Updating archive...'
    %x(7z a #{archive_path} \
      #{extra_file}
    )
    puts "done"
  end

  # Calculate MD5
  print 'Calculating MD5...'
  md5 = %x(md5sum \
    #{archive_path} \
    | cut -d ' ' -f 1
  )
  puts "done"

  puts
  puts "Generated archive #{filename}.7z"
  puts "with MD5 #{md5}"
end
