#!/usr/bin/env ruby
require 'optparse'

colors = {
  _black: "\e[30m",
  red: "\e[31m",
  green: "\e[32m",
  brown: "\e[33m",
  blue: "\e[34m",
  _magenta: "\e[35m",
  cyan: "\e[36m",
  _gray: "\e[37m",
  bg: {
    _black: "\e[40m",
    _red: "\e[41m",
    _green: "\e[42m",
    _brown: "\e[43m",
    _blue: "\e[44m",
    _magenta: "\e[45m",
    _cyan: "\e[46m",
    _gray: "\e[47m"
  },
  nocolor: "\e[0m"
}

certifications = [
  {
    exam: 'OSCP',
    color: colors[:brown],
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
    color: colors[:cyan],
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
    color: colors[:green],
    template: [
      {
        name: 'Official Offensive Security Template v1',
        path: 'src/OSCE-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSEE',
    color: colors[:red],
    template: [
      {
        name: 'Official Offensive Security Template v1',
        path: 'src/OSEE-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSWP',
    color: colors[:blue],
    template: [
      {
        name: 'Official Offensive Security Template v1',
        path: 'src/OSWP-exam-report-template_OS_v1.md'
      }
    ]
  },
  {
    exam: 'OSED',
    color: colors[:cyan],
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
    color: colors[:green],
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

options = {}

subtext = <<~HELPMSG
  Markdown Templates for Offensive Security OSCP, OSWE, OSEE, OSWP, OSEP, OSED Exam Report.

  Sub-commands:
    init     :  Copy a template that you will use to write your report
    generate :  Generate your PDF report and 7z archive

  See 'osert COMMAND --help' for more information on a specific command.
HELPMSG

global = OptionParser.new do |opts|
  opts.banner = 'Usage: osert <subcommand> [options]'
  opts.separator ''
  opts.separator subtext
end

subcommands = {
  'init' => OptionParser.new do |opts|
    opts.banner = 'Usage: init [options]'
    opts.on('-o', '--output REPORT', 'File path to store a copy of the template to write your report')
  end,
  'generate' => OptionParser.new do |opts|
    opts.banner = 'Usage: generate [options]'
    opts.on('-i', '--input REPORT', 'File path to the markdown report to convert to PDF')
    opts.on('-o', '--output PDF', 'File path to store the PDF report')
  end
}

global.order!(into: options)
command = ARGV.shift
subcommands[command].order!(into: options)

# puts "Command: #{command} "
# p options
# puts 'ARGV:'
# p ARGV
# exit 0

case command
when 'init'
  # Choose a certification
  puts "\n"
  certifications.each_with_index do |c, i|
    puts "#{c[:color]}#{i}. #{c[:exam]}#{colors[:nocolor]}"
  end
  print "\n[+] Choose a Certification:"
  choice = gets.chomp
  cert = certifications[choice.to_i]

  # Choose a template
  puts "\n"

  cert[:template].each_with_index do |t, i|
    puts "#{cert[:color]}#{i}. [#{cert[:exam]}] #{t[:name]}#{colors[:nocolor]}"
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

  if options[:output]
    output = options[:output]
  else
    print "\n[+] Enter the path where you want to copy the report template:"
    output = gets.chomp
  end

  # The chosen template will be saved in the HOME directory
  %x(cp -rf #{src} #{output} 2>&1 || cp -rf /usr/share/osert/#{src} #{output})

  %x(sed -i "/^author:.*/c\\author: \[\\"#{author}\\", \\"OSID: #{osid}\\"\]" #{output}/#{File.basename(src)})
  %x(sed -i "/^date: .*/c\\date: $(date +'%Y-%m-%d')" #{output}/#{File.basename(src)})

  puts "\n#{cert[:color]}[+] The #{File.basename(src)} file is saved in #{output} folder. Edit it with your exam notes.#{colors[:nocolor]}"
  puts "\n[+] Then, run #{cert[:color]}osert generate -i #{output}/#{File.basename(src)} -o #{output}#{colors[:nocolor]} for getting your report."
when'generate'
  puts "\n[+] Preparing your final report..."
  # Choose syntax highlight style
  style = 'breezedark'
  print "\n[+] Choose syntax highlight style [#{style}]:"
  choice = gets.chomp
  style = choice unless choice.empty?
  puts style

  if options[:input]
    input = options[:input]
  else
    print "\n[+] Enter the file path where is your markdown report:"
    input = gets.chomp
  end

  if options[:output]
    output = options[:output]
  else
    print "\n[+] Enter the path where you want to store the PDF report:"
    output = gets.chomp
  end

  # Generating report
  puts "\n[+] Generating report..."
  pdf = "#{output}/#{exam}-#{osid}-Exam-Report.pdf"
  # pdf = output.to_s
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
  archive = "#{File.dirname(pdf)}/#{File.basename(pdf, '.pdf')}.7z"
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
