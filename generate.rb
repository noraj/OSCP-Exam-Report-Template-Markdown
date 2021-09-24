#!/usr/bin/env ruby

# Default options
# Uncommment and set your own default options to not get prompted each time
options = {
  # template: 0,
  # osid: 'OS-####',
  # style: 'breezedark',
  # extra_file: false
}

require 'optparse'
OptionParser.new do |opts|
  opts.banner = "Usage: generate.rb [options]"
  opts.on("-t", "--template ID", "Template ID") { |o| options[:template] = o }
  opts.on("-i", "--os-id ID", "OS-ID") { |o| options[:osid] = o }
  opts.on("-s", "--style STYLE", "Code highlight style (or 'd' for default)") { |o| options[:style] = o != 'd' ? o : false  }
  opts.on("-e", "--extra FILE", "Extra file to include in archive (or 'n' for none)") { |o| options[:extra_file] = o != 'n' ? o : false }
end.parse!

templates = [
  {
    exam: 'OSCP',
    name: 'whoisflynn improved template v3.2',
    path: 'src/OSCP-exam-report-template_whoisflynn_v3.2.md'
  },
  {
    exam: 'OSCP',
    name: 'official Offensive Security template v1',
    path: 'src/OSCP-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSCP',
    name: 'official Offensive Security template v2',
    path: 'src/OSCP-exam-report-template_OS_v2.md'
  },
  {
    exam: 'OSWE',
    name: 'official Offensive Security template v1',
    path: 'src/OSWE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSWE',
    name: 'noraj improved template v1',
    path: 'src/OSWE-exam-report-template_noraj_v1.md'
  },
  {
    exam: 'OSCE',
    name: 'official Offensive Security template v1',
    path: 'src/OSCE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSEE',
    name: 'official Offensive Security template v1',
    path: 'src/OSEE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSWP',
    name: 'official Offensive Security template v1',
    path: 'src/OSWP-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSED',
    name: 'official Offensive Security template v1',
    path: 'src/OSED-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSED',
    name: 'epi improved template v1',
    path: 'src/OSED-exam-report-template_epi_v1.md'
  },
  {
    exam: 'OSEP',
    name: 'official Offensive Security template v1',
    path: 'src/OSEP-exam-report-template_OS_v1.md'
  }
]

puts "---[ OffSec Exam Report Generator ]---"

# Choose template
if options.key?(:template) and options[:template].to_i.between?(0, templates.length())
  puts "Chosen template: #{templates[options[:template].to_i][:name]}"
  src = templates[options[:template].to_i][:path]
  exam = templates[options[:template].to_i][:exam]
else
  puts "Available templates;"
  templates.each_with_index do |t,i|
    puts "#{i}. [#{t[:exam]}] #{t[:name]}"
  end
  print 'Choose a template: '
  choice = gets.chomp
  src = templates[choice.to_i][:path]
  exam = templates[choice.to_i][:exam]
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
  puts "Style: #{style}"
elsif options.key?(:style) and options[:style] == options[:style].to_i.to_s and options[:style].to_i.between?(0, styles.length())
  style = styles[options[:style].to_i]
  puts "Style: #{style}"
elsif options.key?(:style) and styles.include?(options[:style])
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

# Optional lab report
extra_file = false
if options.key?(:extra_file)
  if !options[:extra_file] or options[:extra_file].downcase == 'n'
    nil
  else
    extra_file = options[:extra_file]
    puts "Extra file: #{extra_file}"
  end
else
  print 'Do you want to add an external lab report? [y/N]: '
  choice = gets.chomp
  if choice.downcase == 'y'
    print 'Write the path of your lab PDF: '
    extra_file = gets.chomp
  end
end

pdf = "output/#{exam}-#{osid}-Exam-Report.pdf"
archive = "output/#{exam}-#{osid}-Exam-Report.7z"

# Generating report
print 'Generating report...'
%x(pandoc #{src} -o #{pdf} \
  --from markdown+yaml_metadata_block+raw_html \
  --template eisvogel \
  --table-of-contents \
  --toc-depth 6 \
  --number-sections \
  --top-level-division=chapter \
  --highlight-style #{style}
)
puts "done"

# Removing old archive
print 'Cleaning archive...'
%x(rm #{archive})
puts "done"

# Generating archive
print 'Generating archive...'
%x(7z a #{archive} \
  #{File.expand_path(pdf)}
)
puts "done"

# Updating archive
if extra_file
  print 'Updating archive...'
  %x(7z a #{archive} \
    #{File.expand_path(extra_file)}
  )
  puts "done"
end

# Calculate MD5
print 'Calculating MD5...'
md5 = %x(md5sum \
  #{File.expand_path(pdf)} \
  | cut -d ' ' -f 1
)
puts "done"

puts
puts "Generated archive #{archive}"
puts "with MD5 #{md5}"
