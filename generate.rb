#!/usr/bin/env ruby

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
  }
]

# Choose template
puts 'Choose a template:'
templates.each_with_index do |t,i|
  puts "#{i}. [#{t[:exam]}] #{t[:name]}"
end
choice = gets.chomp
src = templates[choice.to_i][:path]
exam = templates[choice.to_i][:exam]

# Enter your OS id
puts 'Enter your OS id'
print 'OS-'
osid = 'OS-' + gets.chomp

# Choose syntax highlight style
style = 'breezedark'
puts "Choose syntax highlight style [#{style}]"
choice = gets.chomp
style = choice unless choice.empty?
puts style

# Generating report
puts 'Generating report...'
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

# Generating archive
puts 'Generating archive...'
%x(7z a output/#{exam}-#{osid}-Exam-Report.7z \
  -p#{osid} \
  #{File.expand_path(pdf)}
)

# Optional lab report
puts 'Do you want to add an external lab report? [y/N]'
choice = gets.chomp
if choice.downcase == 'y'
  puts 'Write the path of your lab PDF'
  lab = gets.chomp
  puts 'Updating archive...'
  %x(7z a output/#{exam}-#{osid}-Exam-Report.7z \
    -p#{osid} \
    #{File.expand_path(lab)}
  )
end
