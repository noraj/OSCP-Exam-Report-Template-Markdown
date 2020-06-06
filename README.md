# OSCP Exam Report Template in **Markdown**

[![Rawsec's CyberSecurity Inventory](https://inventory.rawsec.ml/img/badges/Rawsec-inventoried-FF5050_flat-square.svg)](https://inventory.rawsec.ml/tools.html#OSCP%20Exam%20Report%20Template%20in%20Markdown)
[![GitHub stars](https://img.shields.io/github/stars/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/network)
[![GitHub license](https://img.shields.io/github/license/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/blob/master/LICENSE)

## Fork & update/overhaaul of noraj's original script to provide more flexibility & ease in report generation.

- included options for custom-made template & added TJNull's OSCP exam report from [TJ-JPT jex file](https://github.com/tjnull/TJ-JPT)
- added a variety of selections in menu to create more options without custom report mods
- created setup.sh file to install & stage requirements w/o manual placement of dependencies


## Requirements

- kali with sudo access
- report written in md
- ruby installed (presume script wiill be running from kali, so not included in setup.sh)

## Usage

1. Write your report in **markdown**.
2. Run ```git clone https://github.com/initinfosec/OSCP-Exam-Report-Template-Markdown.git```
3. Run ```./setup.sh``` to install necessary software & template (pandoc, LaTeX-full, p7zip-full, eisvogel template)
4. Copy markdown report **below** header information in desired template
5. Run ```ruby generate.rb``` to go through automatic generation detailed below.
6. Step through menu to make choices - **use numbers only for selections** - header & report will modify according to selections
7. PDF and 7z archive will be generated
8. Manually verify output before submitting.


### Automatic

There is a script that will:

1. Let you choose the template
2. Let you choose the syntax highlight style
3. Enter your OS-ID & email
4. Choose report type: (lab & exam or exam only)
5. Let you choose the titlepage colour, titlepage text colour
3. Generate the PDF
4. Generate the 7z archive

### notices / caveats

- no fancy input verification - make sure your OS-ID & email are correct. Make sure your selections from menu options are numbers only
- no option to choose colours not on menu - TBD - if you want a different colour, manual usage is recommended
- no need to modify header info before running ruby script - will edit needed info as you go
- make sure image paths are correct (either full/explicit or reletive paths) before generation so pandoc includes them in the PDF.


--------------------------
**From noraj:**

I created an **OSCP Exam Report Template in Markdown** so LaTeX, Microsoft Office Word, LibreOffice Writter are no longer needed during your OSCP exam!

Now you can be efficient and faster during your exam report redaction! 

**whoisflynn improved template v3.2**

![](https://i.imgur.com/Z344YCQ.png)
![](https://i.imgur.com/wegbNYr.png)

**Official Offensive Security Template v1**

![](https://i.imgur.com/9zoWFfr.png)
![](https://i.imgur.com/MWSgxfh.png)


### Manual

Generate the report PDF from the markdown template:

```
pandoc src/OSCP-exam-report-template_whoisflynn_v3.2.md \
-o output/OSCP-OS-XXXXX-Exam-Report.pdf \
--from markdown+yaml_metadata_block+raw_html \
--template eisvogel \
--table-of-contents \
--toc-depth 6 \
--number-sections \
--top-level-division=chapter \
--highlight-style breezedark
```

You can change the code syntax highlight theme with [`--highlight-style`](https://pandoc.org/MANUAL.html#option--highlight-style).

## Color sets

Well rendering color sets you can use in the template YAML frontmatter:

titlepage-color          | titlepage-text-color | titlepage-rule-color
-------------------------|----------------------|---------------------
`DC143C` (Crimson)       | `FFFFFF` (White)     | `FFFFFF` (White)
`00FF7F` (SpringGreen)   | `006400` DarkGreen   | `000000` (Black)
`1E90FF` (DodgerBlue)    | `FFFAFA` (Snow)      | `FFFAFA` (Snow)
`483D8B` (DarkSlateBlue) | `FFFAFA` (Snow)      | `FFFAFA` (Snow)
`FFD700` (Gold)          | `000000` (Black)     | `000000` (Black)
`FFEFD5` (PapayaWhip)    | `000000` (Black)     | `000000` (Black)
`FF8C00` (DarkOrange)    | `000000` (Black)     | `000000` (Black)
`FFEF96` (no name)       | `50394C` (no name)   | `50394C` (no name)

## Mentions

- Mentions on social medias: [![GitSpo Mentions](https://gitspo.com/badges/mentions/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://gitspo.com/mentions/noraj/OSCP-Exam-Report-Template-Markdown)

- John Hammond - OSCP - Taking Notes & Resources (video)
  [![OSCP - Taking Notes & Resources](http://img.youtube.com/vi/MQGozZzHUwQ/0.jpg)](https://www.youtube.com/watch?v=MQGozZzHUwQ)
- 8th [Top Offensive Security Open Source Projects](https://awesomeopensource.com/projects/offensive-security) (08 Apr. 2020)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown.svg)](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown)

## Credits

Report Templates:

- Official Offensive Security Template v1 (UNLICENSED): https://support.offensive-security.com/oscp-exam-guide/#suggested-documentation-templates
- whoisflynn improved template v3.2 (UNLICENSED): https://github.com/whoisflynn/OSCP-Exam-Report-Template

Pandoc Template:

- Eisvogel ([LICENCE](https://github.com/Wandmalfarbe/pandoc-latex-template/blob/master/LICENSE)): https://github.com/Wandmalfarbe/pandoc-latex-template

Placeholder image:

- Generated by https://imgplaceholder.com/

OffSec Logo image:

- From [TJ-JPT jex file](https://github.com/tjnull/TJ-JPT)
