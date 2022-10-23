#!/usr/bin/env ruby
require 'getoptlong'

black = "\e[30m"
red = "\e[31m"
green = "\e[32m"
brown = "\e[33m"
blue = "\e[34m"
magenta = "\e[35m"
cyan = "\e[36m"
gray = "\e[37m"

bg_black = "\e[40m"
bg_red = "\e[41m"
bg_green = "\e[42m"
bg_brown = "\e[43m"
bg_blue = "\e[44m"
bg_magenta = "\e[45m"
bg_cyan = "\e[46m"
bg_gray = "\e[47m"

nocolor = "\e[0m"

certifications = [
  {
    exam: 'OSCP',
    color: brown,
    template: [
      {
          name: 'Whoisflynn Improved Template v3.2',
          path: 'src/OSCP-exam-report-template_whoisflynn_v3.2.md'
      },
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSCP-exam-report-template_OS_v1.md'
      },
      {
          name: 'Official Offensive Security Template v2',
          path: 'src/OSCP-exam-report-template_OS_v2.md'
      }
    ]
  },
  {
    exam: 'OSWE',
    color: cyan,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSWE-exam-report-template_OS_v1.md'
      },
      {
          name: 'Noraj Improved Template v1',
          path: 'src/OSWE-exam-report-template_noraj_v1.md'
      },
      {
          name: 'XL-SEC Improved Template v1',
          path: 'src/OSWE-exam-report-template_xl-sec_v1.md'
      }
    ]
  },
  {
    exam: 'OSCE',
    color: green,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSCE-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSEE',
    color: red,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSEE-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSWP',
    color: blue,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSWP-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSED',
    color: cyan,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSED-exam-report-template_OS_v1.md'
      },
      {
          name: 'Epi Improved Template v1',
          path: 'src/OSED-exam-report-template_epi_v1.md'
      }
    ]
  },
  {
    exam: 'OSEP',
    color: green,
    template: [
      {
          name: 'Official Offensive Security Template v1',
          path: 'src/OSEP-exam-report-template_OS_v1.md'
      },
      {
          name: 'Ceso Improved Template v1',
          path: 'src/OSEP-exam-report-template_ceso_v1.md'
      }
    ]
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
    # Choose a certification
    puts "\n"
    certifications.each_with_index do |c,i|
         puts "#{c[:color]}#{i}. #{c[:exam]}#{nocolor}"
    end
    print "\n[+] Choose a Certification:"
    choice = gets.chomp
    cert = certifications[choice.to_i]

    # Choose a template
    puts "\n"
    
    cert[:template].each_with_index do |t,i|
      puts "#{cert[:color]}#{i}. [#{cert[:exam]}] #{t[:name]}#{nocolor}"
    end
    print "\n[+] Choose a Template:"
    choice = gets.chomp
    src = cert[:template][choice.to_i][:path]
    exam = cert[:exam]
    
    # Enter your OS id
    print "\n[+] Enter your OS ID: OS-"
    osid = gets.chomp

    # Enter your email address
    print "\n[+] Enter your email address as author:"
    author = gets.chomp

    # The chosen template will be saved in the HOME directory
    %x( cp -rf #{src} #{ENV['HOME']} 2>&1 || cp -rf /usr/share/osert/#{src} #{ENV['HOME']} )
    
    %x( sed -i "/^author:.*/c\\author: \[\\"#{author}\\", \\"OSID: #{osid}\\"\]" #{ENV['HOME']}/#{File.basename(src)})
    %x( sed -i "/^date: .*/c\\date: $(date +'%Y-%m-%d')" #{ENV['HOME']}/#{File.basename(src)})
    
    puts "\n#{cert[:color]}[+] The #{File.basename(src)} file is saved in your HOME folder. Edit it with your exam notes.#{nocolor}"
    puts "\n[+] Then, run #{cert[:color]}osert -i #{ENV['HOME']}/#{File.basename(src)} -o #{ENV['HOME']}/#{exam}-OS-#{osid}-Exam-Report.pdf#{nocolor} for getting your report."

elsif inflag == 1 and help != 1
  puts "\n[+] Preparing your final report..."
    # Choose syntax highlight style
    style = 'breezedark'
    print "\n[+] Choose syntax highlight style [#{style}]:"
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
      --resource-path=.:src \
      --resource-path=.:/usr/share/osert/src
    )
    puts "\n[+] PDF generated at #{pdf}"

    # Preview
    puts "\n[+] Do you want to preview the report? [y/N]"
    print '[>] '
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
    print '[>] '
    choice = gets.chomp
    if choice.downcase == 'y'
      print "\n[+] Write the path of your lab PDF:"
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
