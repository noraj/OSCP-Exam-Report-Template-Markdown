#!/usr/bin/env ruby
require 'getoptlong'

templates = [
  {
    exam: 'OSCP',
    name: 'Whoisflynn Improved Template v3.2',
    path: 'src/OSCP-exam-report-template_whoisflynn_v3.2.md'
  },
  {
    exam: 'OSCP',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSCP-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSCP',
    name: 'Official Offensive Security Template v2',
    path: 'src/OSCP-exam-report-template_OS_v2.md'
  },
  {
    exam: 'OSWE',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSWE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSWE',
    name: 'Noraj Improved Template v1',
    path: 'src/OSWE-exam-report-template_noraj_v1.md'
  },
  {
    exam: 'OSWE',
    name: 'XL-SEC Improved Template v1',
    path: 'src/OSWE-exam-report-template_xl-sec_v1.md'
  },
  {
    exam: 'OSCE',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSCE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSEE',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSEE-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSWP',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSWP-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSED',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSED-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSED',
    name: 'Epi Improved Template v1',
    path: 'src/OSED-exam-report-template_epi_v1.md'
  },
  {
    exam: 'OSEP',
    name: 'Official Offensive Security Template v1',
    path: 'src/OSEP-exam-report-template_OS_v1.md'
  },
  {
    exam: 'OSEP',
    name: 'Ceso Improved Template v1',
    path: 'src/OSEP-exam-report-template_ceso_v1.md'
  }
]
opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--input', '-i', GetoptLong::REQUIRED_ARGUMENT ],
    [ '--output', '-o', GetoptLong::REQUIRED_ARGUMENT ]
)
input = nil
output = nil
help = 0
inflag = 0
outflag = 0

puts %x(base64 -d <<<"H4sIAAAAAAAAA7XWXQrDIAwA4PeeIlAKIjLvf7tp3UyiJpr++DDF2m+JwziAJ9q2siim5vJHvGUdmSlO6vPAXw8uEqy2MmEHh9gKOgB3zSKoG6INqAa2FOrGMGfAJHUjmh3jKgeXOS+QHHRPtPfBUHe2PgYIZL5OAngcggTWR3lPHVmZwA++Q5fy3EQwlNHv58IIPUbIfRnsvvcUuwhpLtoe4raQcbeH6ynfbq+ChpMiHb726F2rDH8NCwQvN0KF8E0vYQ04RsM0soMJozsgKvkHZs1L9lr+xktFR8+JXX5pesmT/Evn9PXGfw3xCyRvCFOsCAAA" | gunzip)
puts "\nOffensive Security Exam Report Template"

opts.each do |opt, arg|
    case opt
        when '--help'
          help = 1

          puts <<-EOF

Markdown Templates for Offensive Security OSCP, OSWE, OSCE, OSEE, OSWP Exam Report.

-h, --help:
     Print this help.

-i report.md, --input report.md:
     File path to the markdown report to convert to PDF.

-o report.pdf, --output report.pdf:
     File path to store the PDF report.

Run 'osert' for choosing your template.
Run 'osert -i filename.md -o filename.pdf' when your markdown report is ready.

            EOF
            exit 0
        when '--input'
          input = arg
          inflag = 1
        when '--output'
          outflag = 1
          output = arg
    end
end

if help != 1 and inflag != 1 and outflag != 1
    # Choose template
    puts "\n[+] Choose a template:"
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

    # The chosen template will be saved in the HOME directory
    puts "\n[+] The #{File.basename(src)} file is saved in your HOME folder. Edit it with your exam notes."
    puts "\nThen, run \"osert -i #{File.basename(src)} -o #{File.basename(src, ".md")}.pdf\" for getting your report."
    %x(cp -rf #{src} #{ENV['HOME']})

elsif inflag == 1 and help != 1
  puts "\n[+] Preparing your final report..."
    # Choose syntax highlight style
    style = 'breezedark'
    puts "\n[+] Choose syntax highlight style [#{style}]"
    print '> '
    choice = gets.chomp
    style = choice unless choice.empty?
    puts style

    # Generating report
    puts "\n[+] Generating report..."
    #pdf = "output/#{exam}-#{osid}-Exam-Report.pdf"
    pdf = "#{output}"
    %x(pandoc #{input} -o #{pdf} \
      --from markdown+yaml_metadata_block+raw_html \
      --template eisvogel \
      --table-of-contents \
      --toc-depth 6 \
      --number-sections \
      --top-level-division=chapter \
      --highlight-style #{style} \
      --resource-path=.:src
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
    archive = "#{File.dirname(pdf)}/#{File.basename(pdf,".pdf")}.7z"
    %x(7z a #{archive} \
      #{File.expand_path(pdf)}
    )

    # Optional lab report
    puts "\n[+] Do you want to add an external lab report? [y/N]"
    print '> '
    choice = gets.chomp
    if choice.downcase == 'y'
      puts "\n[+] Write the path of your lab PDF:"
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
end
