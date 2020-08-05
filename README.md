# Offensive Security Exam Report Template in Markdown

[![Rawsec's CyberSecurity Inventory](https://inventory.rawsec.ml/img/badges/Rawsec-inventoried-FF5050_flat-square.svg)](https://inventory.rawsec.ml/tools.html#OSCP%20Exam%20Report%20Template%20in%20Markdown)
[![GitHub stars](https://img.shields.io/github/stars/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/network)
[![GitHub license](https://img.shields.io/github/license/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/blob/master/LICENSE)

I created an **Offensive Security Exam Report Template in Markdown** so LaTeX, Microsoft Office Word, LibreOffice Writer are no longer needed during your Offensive Security OSCP, OSWE, OSCE, OSEE, OSWP exam!

Now you can be efficient and faster during your exam report redaction!

- :rocket: **Speed up writing**, don't loose time during the 24 hours of exam report redaction
- :star: **No formatting hassle with WYSIWYG editors**, byebye unwanted whitespaces and linefeeds from Microsoft Office Word and LibreOffice Writer
- :memo: **Re-use your Markdown notes**, you'll be so glad not having to reformat the bold and italic from your Markdown notes into the report
- :lock: **Version control ready**, save your markdown template into a PRIVATE git repository, you know have an incremental backup, version control works with Markdown (.md) as it's text but not with binaries (.doc, .odt)
- :pen: **Use your favorite editor or note taking app**, with Markdown you'll be able to use your favorite editor (VSCode, Atom, etc.) or note taking app (Vnote, QOwnNotes, Boostnote, etc.) to write your exam report, you won't have to switch to Windows to use MS Word.
- :tophat: **Clean & professional style**, a professional looking report for your professional certification
- :ok_hand: **Error free**, use the generation script to generate the report and archive, you won't do any [submission format and name](https://support.offensive-security.com/oscp-exam-guide/#submission-format-and-name) mistake that way

![](https://i.imgur.com/XiXIZg3.png)

Examples:

**OSCP whoisflynn improved template v3.2**

![](https://i.imgur.com/Z344YCQ.png)
![](https://i.imgur.com/wegbNYr.png)

**OSCP Official Offensive Security Template v1**

![](https://i.imgur.com/9zoWFfr.png)
![](https://i.imgur.com/MWSgxfh.png)

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- LaTeX (eg. [TeX Live](http://www.tug.org/texlive/)) in order to get `pdflatex` or `xelatex`
- [Eisvogel Pandoc LaTeX PDF Template](https://github.com/Wandmalfarbe/pandoc-latex-template#installation)
- [p7zip](http://p7zip.sourceforge.net/) (if you want to use the script, for generating the archive)

## Usage

Write your report in **markdown**.

### Automatic

There is a script that will:

1. Let you choose the template
2. Let you choose the syntax highlight style
3. Generate the PDF
4. Generate the 7z archive

```
ruby generate.rb
```

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

## Available templates

Report Templates:

- **OSCP**
  - [Official Offensive Security Template v1](output/OSCP-exam-report-template_OS_v1.pdf)
  - [whoisflynn improved template v3.2](output/OSCP-exam-report-template_whoisflynn_v3.2.pdf)
- **OSWE**
  - [Official Offensive Security Template v1](output/OSWE-exam-report-template_OS_v1.pdf)
  - [noraj improved template v1](output/OSWE-exam-report-template_noraj_v1.pdf)
- **OSCE**
  - [Official Offensive Security Template v1](output/OSCE-exam-report-template_OS_v1.pdf)
- **OSEE**
  - [Official Offensive Security Template v1](output/OSEE-exam-report-template_OS_v1.pdf)
- **OSWP**
  - [Official Offensive Security Template v1](output/OSWP-exam-report-template_OS_v1.pdf)

## Mentions

- Recent mentions on social medias: [![GitSpo Mentions](https://gitspo.com/badges/mentions/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://gitspo.com/noraj/OSCP-Exam-Report-Template-Markdown/mentions)

- John Hammond - OSCP - Taking Notes & Resources (video)
  [![OSCP - Taking Notes & Resources](http://img.youtube.com/vi/MQGozZzHUwQ/0.jpg)](https://www.youtube.com/watch?v=MQGozZzHUwQ)
- 6th [Top Offensive Security Open Source Projects](https://awesomeopensource.com/projects/offensive-security) (05 Aug. 2020)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown.svg)](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown)

## Credits

Report Templates:

- **OSCP**
  - [Official Offensive Security Template v1](https://support.offensive-security.com/oscp-exam-guide/#suggested-documentation-templates) (UNLICENSED)
  - [whoisflynn improved template v3.2](https://github.com/whoisflynn/OSCP-Exam-Report-Template) (UNLICENSED)
- **OSWE**
  - [Official Offensive Security Template v1](https://support.offensive-security.com/oswe-exam-guide/#suggested-documentation-templates) (UNLICENSED)
  - [noraj improved template v1](src/OSWE-exam-report-template_noraj_v1.md) (UNLICENSED)
- **OSCE**
  - [Official Offensive Security Template v1](https://support.offensive-security.com/osce-exam-guide/#suggested-documentation-templates) (UNLICENSED)
- **OSEE**
  - [Official Offensive Security Template v1](https://support.offensive-security.com/osee-exam-guide/#documentation-requirements) (UNLICENSED)
- **OSWP**
  - [Official Offensive Security Template v1](https://support.offensive-security.com/oswp-exam-guide/#suggested-documentation-templates) (UNLICENSED)

Pandoc Template:

- Eisvogel ([LICENCE](https://github.com/Wandmalfarbe/pandoc-latex-template/blob/master/LICENSE)): https://github.com/Wandmalfarbe/pandoc-latex-template

Placeholder image:

- Generated by https://imgplaceholder.com/
