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
    exam: 'OSWE',
    name: 'XL-SEC improved template v1',
    path: 'src/OSWE-exam-report-template_xl-sec_v1.md'
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
  },
  {
    exam: 'OSEP',
    name: 'ceso improved template v1',
    path: 'src/OSEP-exam-report-template_ceso_v1.md'
  }
]

# Choose template
puts '[+] Choose a template:'
templates.each_with_index do |t,i|
  puts "#{i}. [#{t[:exam]}] #{t[:name]}"
end
print '> '
choice = gets.chomp
src = templates[choice.to_i][:path]
exam = templates[choice.to_i][:exam]

# Enter your OS id
puts "\n[+] Enter your OS id"
print '> OS-'
osid = 'OS-' + gets.chomp

# Choose syntax highlight style
style = 'breezedark'
puts "\n[+] Choose syntax highlight style [#{style}]"
print '> '
choice = gets.chomp
style = choice unless choice.empty?
puts style

# Generating report
puts "\n[+] Generating report..."
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
puts "\n[+] PDF generated at #{pdf}"

# Preview
puts "\n[+] Do you want to preview the report? [y/N]"
print '> '
choice = gets.chomp
if choice.downcase == 'y'
  viewer = fork do
    exec "xdg-open #{pdf}"
  end
  Process.detach(viewer)
end

# Generating archive
puts "\n[+] Generating archive..."
archive = "output/#{exam}-#{osid}-Exam-Report.7z"
%x(7z a #{archive} \
  #{File.expand_path(pdf)}
)

# Optional lab report
puts "\n[+] Do you want to add an external lab report? [y/N]"
print '> '
choice = gets.chomp
if choice.downcase == 'y'
  puts "\n[+] Write the path of your lab PDF"
  print '> '
  lab = gets.chomp
  puts "\n[+] Updating archive..."
  %x(7z a #{archive} \
    #{File.expand_path(lab)}
  )
end

puts "\n[+] Archive generated at #{archive}"

# Calculate MD5
puts "\n[+] Calculating MD5 of the archive..."
require 'digest'
md5 = Digest::MD5.hexdigest File.read(archive)
puts "\n[+] Archive MD5 (upload integrity check): #{md5}"
