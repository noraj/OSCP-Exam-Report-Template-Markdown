#!/usr/bin/env ruby

#array for template choices
templates = [

  {
    name: 'User-Generated/Custom OSCP Report',
    path: 'src/custom_OSCP_report.md'
  },
  {
    name: 'TJNull (unofficial md) OffSec Template v1',
    path: 'src/TJNull_OSCP_Report_Template.md'
  },
  {
    name: 'whoisflynn improved template v3.2',
    path: 'src/OSCP-exam-report-template_whoisflynn_v3.2.md'
  },
  {
    name: 'Official Offensive Security Template v1',
    path: 'src/OSCP-exam-report-template_OS_v1.md'
  }
]

# Choose template
puts 'Report Templace Choices:'
templates.each_with_index do |t,i|
  puts "#{i}. #{t[:name]}"
end
print 'Choose a template #:  '
choice = gets.chomp
src = templates[choice.to_i][:path]
sel = templates[choice.to_i][:name]
puts "Using #{sel}"
puts ""

# preface
puts "This script assumes you've already placed your writeup contents into #{src}\nIf not, press Q to exit script, place report content into desired template, and re-run script.\nIf ready & correct selection is made, press any other key to continue."
puts ""
resp = gets.chomp
exit if resp == 'q' || resp == 'Q'


# Enter your OS ID
puts 'Enter your OS ID #'
print 'OS-'
val = gets.chomp
osid = 'OS-' + val
puts ""


# Enter your primary offsec email
puts 'Enter your primary OffSec email'
print 'email:  '
val = gets.chomp
email = val
puts ""

# write email & OS-ID to cover page via md header

file_data = ""
keyword = "author: "
replacement = "author: ['#{email}', '#{osid}']"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end
   

# get date of report
currDate = Time.now.strftime("%F")
date = currDate
puts "Enter date of report in YYYY-MM-DD format. (or enter for #{currDate})"
print "Date (YYYY-MM-DD):  "
val = gets.chomp
date = val unless val.empty?
puts "Report date set as #{date}."
puts ""

# write report date to cover page via md header

file_data = ""
keyword = "date: "
replacement = "date: '#{date}'"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end


# choose report type

#array for report types
reportType = [
  {
    name: 'OSCP Exam Report (Only)',
    value: 'OSCP Exam',
    title: '# Offensive Security Exam Penetration Test Report'
  },

  {
    name: 'PWK Lab Report & OSCP Exam Report',
    value: 'PWK Lab & OSCP Exam',
    title: '# Offensive Security Lab and Exam Penetration Test Report'
  }
]

# Choose report type
report = 'OSCP Exam'
title = '# Offensive Security Exam Penetration Test Report'
sel = 'OSCP Exam Report (Only)'
puts "Report Types:"

reportType.each_with_index do |r,i|
  puts "#{i}. #{r[:name]}"
end
print "Choose Report Type # (current selection: #{sel}):  "
choice = gets.chomp
sel = reportType[choice.to_i][:name] unless choice.empty?
report = reportType[choice.to_i][:value] unless choice.empty?
title = reportType[choice.to_i][:title] unless choice.empty?
puts "Report type chosen: #{sel}"
puts ""

# change report type on md header in report file
file_data = ""
keyword = "subtitle: "
replacement = "subtitle: #{report}"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end

   
# change report type in main title of report
file_data = ""
keyword = "# Offensive Security"
replacement = "#{title}"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end



#array for syntax highlight style choices
syntaxStyles = [

  {
    name: 'breezedark',
    value: 'breezedark'
  },
  {
     name: 'espresso',
     value: 'espresso'
   },
   {
     name: 'haddock',
     value: 'haddock'
    },
    {
     name: 'kate',
     value: 'kate'
    },
   {
     name: 'monochrome',
     value: 'monochrome'
    },
   {
     name: 'pygments',
     value: 'pygments'
    },
   {
     name: 'tango',
     value: 'tango'
    },
   {
     name: 'zenburn',
     value: 'zenburn'
    }
]

# Choose syntax highlight style
style = 'tango'
sel = 'tango'
puts "Choose syntax highlight style # (current selection: #{style}):  "
syntaxStyles.each_with_index do |s,i|
  puts "#{i}. #{s[:name]}"
end
print 'syntax highlight style #:  '
choice = gets.chomp
style = syntaxStyles[choice.to_i][:value] unless choice.empty?
sel = syntaxStyles[choice.to_i][:name] unless choice.empty?
puts "Using #{sel} as syntax highlight style."
puts ""


#array for title page colour choices
pageColour = [

  {
    name: 'White',
    value: %Q("FFFFFF")
  },
  {
     name: 'Black',
     value: %Q("000000")
   },
   {
     name: 'DarkGreen',
     value: %Q("006400")
   },
   {
      name: 'Snow',
      value: %Q("FFFAFA")
   },
   {
     name: 'Crimson',
     value: %Q("DC143C")
    },
   {
     name: 'SpringGreen (mint/lively green)',
     value: %Q("00FF7F")
    },
   {
     name: 'DodgerBlue (mid/bright blue)',
     value: %Q("1E90FF")
    },
   {
     name: 'DarkSlateBlue',
     value: %Q("483D8B")
    },
   {
     name: 'Gold',
     value: %Q("FFD700")
    },
   {
     name: 'PapayaWhip (light tan)',
     value: %Q("FFEFD5")
    },
   {
     name: 'DarkOrange',
     value: %Q("FF8C00")
    },
   {
     name: 'PurpleTaupe',
     value: %Q("50394C")
    },
   {
     name: 'Drover (yellow cream)',
     value: %Q("FFEF96")
    }
]

# Choose title page background colour
titlepageColor = '483D8B'
sel = 'DarkSlateBlue'
puts "Title Page Background Color Options:"

pageColour.each_with_index do |c,i|
  puts "#{i}. #{c[:name]}"
end
print "Title Page Background Color # (current selection: #{sel}):  "
choice = gets.chomp
sel = pageColour[choice.to_i][:name] unless choice.empty?
titlepageColor = pageColour[choice.to_i][:value] unless choice.empty?
puts "Using #{sel} for Title Page Background Color"
puts ""

# change titlepage-color on md header in report file
file_data = ""
keyword = "titlepage-color"
replacement = "titlepage-color: #{titlepageColor}"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end
   

# array for title page text color

textColour = [

  {
    name: 'White',
    value: %Q("FFFFFF")
  },
  {
     name: 'Black',
     value: %Q("000000")
   },
   {
      name: 'Snow',
      value: %Q("FFFAFA")
   },
   {
     name: 'DarkGreen',
     value: %Q("006400")
   },
   {
     name: 'PurpleTaupe',
     value: %Q("50394C")
   }
]

# Choose title page text colour
sel = 'White'
titlepageTextColor = %Q("FFFFFF")
puts "Choose Title Page Text Color Options:"
textColour.each_with_index do |c,i|
  puts "#{i}. #{c[:name]}"
end
print "Title Page Text Color # (current selection: #{sel}):  "
choice = gets.chomp
titlepageTextColor = textColour[choice.to_i][:value] unless choice.empty?
sel = textColour[choice.to_i][:name] unless choice.empty?
puts "Using #{sel} for Title Page Text Color."
puts ""



# change titlepage-text-color on md header in report file
file_data = ""
keyword = "titlepage-text-color"
replacement = "titlepage-text-color: #{titlepageTextColor}"
IO.foreach(src) do |line|
   file_data += line.gsub(/^.*#{Regexp.quote(keyword)}.*$/, replacement)
end

File.open(src, 'w') do |line|
   line.write file_data
end



# Generating report
puts 'Generating report...'
pdf = "output/OSCP-#{osid}-Exam-Report.pdf"
zipfile = "output/OSCP-#{osid}-Exam-Report.7z"
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
puts 'Generating password-protected 7z archive...'
%x(7z a output/OSCP-#{osid}-Exam-Report.7z \
  -p#{osid} \
  #{File.expand_path(pdf)}
)

puts "Generated as #{pdf} & #{zipfile}"
puts ""
puts 'Complete. Please double-check for accuracy before submittal.'
puts ""
