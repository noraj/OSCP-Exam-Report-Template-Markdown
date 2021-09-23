#!/usr/bin/env ruby

puts "---[ OffSec Exam Report Generator ]---"

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

# Choose template
puts "Available templates:"
templates.each_with_index do |t,i|
  puts "#{i}. [#{t[:exam]}] #{t[:name]}"
end
print 'Choose a template: '
choice = gets.chomp
src = templates[choice.to_i][:path]
exam = templates[choice.to_i][:exam]

# Enter your OS id
print 'Enter your OS id: OS-'
osid = 'OS-' + gets.chomp

# Choose syntax highlight style
style = 'breezedark'
styles = %x(pandoc --list-highlight-styles).split("\n")
puts "Available highlight styles:"
styles.each_with_index do |s,i|
  puts "#{i}. #{s}"
end
print "Choose syntax highlight style [#{style}] "
choice = gets.chomp
style = styles[choice.to_i] unless choice.empty?

# Generating report
print 'Generating report...'
pdf = "output/#{exam}-#{osid}-Exam-Report.pdf"
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

# Generating archive
print 'Generating archive...'
archive = "output/#{exam}-#{osid}-Exam-Report.7z"
%x(7z a #{archive} \
  #{File.expand_path(pdf)}
)
puts "done"

# Optional lab report
print 'Do you want to add an external lab report? [y/N] '
choice = gets.chomp
if choice.downcase == 'y'
  puts 'Write the path of your lab PDF'
  lab = gets.chomp
  print 'Updating archive...'
  %x(7z a #{archive} \
    #{File.expand_path(lab)}
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
