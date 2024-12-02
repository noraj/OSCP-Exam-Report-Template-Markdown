# Offensive Security Exam Report Template in Markdown

[![Rawsec's CyberSecurity Inventory](https://inventory.raw.pm/img/badges/Rawsec-inventoried-FF5050_flat-square.svg)](https://inventory.raw.pm/tools.html#OSCP%20Exam%20Report%20Template%20in%20Markdown)
[![GitHub stars](https://img.shields.io/github/stars/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/network)
[![GitHub license](https://img.shields.io/github/license/noraj/OSCP-Exam-Report-Template-Markdown?style=flat-square)](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/blob/master/LICENSE)

I created an **Offensive Security Exam Report Template in Markdown** so LaTeX, Microsoft Office Word, LibreOffice Writer are no longer needed during your Offensive Security OSCP, OSWE, OSEE, OSWP, OSEP, OSED, OSWA, OSDA, OSMR, OSTH, OSIR exam!

Now you can be efficient and faster during your exam report redaction!

- :rocket: **Speed up writing**, don't lose time during the 24 hours of exam report redaction
- :star: **No formatting hassle with WYSIWYG editors**, byebye unwanted whitespaces and linefeeds from Microsoft Office Word and LibreOffice Writer
- :memo: **Re-use your Markdown notes**, you'll be so glad not having to reformat the bold and italic from your Markdown notes into the report
- :lock: **Version control ready**, save your markdown template into a PRIVATE git repository, you now have an incremental backup, version control works with Markdown (.md) as it's text but not with binaries (.doc, .odt)
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

Examples for common distros:

- ArchLinux: `pacman -S p7zip haskell-pandoc texlive-basic texlive-fontsextra texlive-fontsrecommended texlive-latexextra`
- openSUSE: `zypper in texlive-scheme-medium pandoc p7zip-full`
- Ubuntu: `apt install texlive-latex-recommended texlive-fonts-extra texlive-latex-extra pandoc p7zip-full`

## Usage

Write your report in **markdown**.

### Automatic

There is a script that will:

1. Let you choose the template
2. Let you choose the syntax highlight style
3. Generate the PDF (+ preview option)
4. Generate the 7z archive
5. Output MD5 hash for verification after uploading

Choose and copy a template that you will use to write your report:

```bash
ruby osert.rb init
```

Generate your PDF report and 7z archive

```bash
ruby osert.rb generate
```

> [!TIP]
> If you run the generation several times, you may want to check the options (`ruby osert.rb generate -h`) to save time on the interactive prompt.

> [!NOTE]
> `osert` is available as an official package on BlackArch Linux: `pacman -S osert`.
>
> [![BlackArch package](https://repology.org/badge/version-for-repo/blackarch/osert.svg)](https://repology.org/project/osert/versions)

### Manual

Generate the report PDF from the markdown template:

```bash
pandoc src/OSCP-exam-report-template_whoisflynn_v3.2.md \
-o output/OSCP-OS-XXXXX-Exam-Report.pdf \
--from markdown+yaml_metadata_block+raw_html \
--template eisvogel \
--table-of-contents \
--toc-depth 6 \
--number-sections \
--top-level-division=chapter \
--highlight-style breezedark \
--resource-path=.:src
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

Syntax highlight themes can be listed with `pandoc --list-highlight-styles`.

## Available templates

Report Templates:

Network Penetration Testing:

- **OSCP**
  - [Official Offensive Security Template v1](output/examples/OSCP-exam-report-template_OS_v1.pdf)
  - [Official Offensive Security Template v2](output/examples/OSCP-exam-report-template_OS_v2.pdf)
  - [whoisflynn][whoisflynn] improved [template](output/examples/OSCP-exam-report-template_whoisflynn_v3.2.pdf) v3.2
- **OSWP**
  - [Official Offensive Security Template v1](output/examples/OSWP-exam-report-template_OS_v1.pdf)
- **OSEP**
  - [Official Offensive Security Template v1](output/examples/OSEP-exam-report-template_OS_v1.pdf)
  - [ceso][ceso] improved [template](output/examples/OSEP-exam-report-template_ceso_v1.pdf) v1

Web Application:

- **OSWA**
  - [Official Offensive Security Template v1](output/examples/OSWA-exam-report-template_OS_v1.pdf)
- **OSWE**
  - [Official Offensive Security Template v1](output/examples/OSWE-exam-report-template_OS_v1.pdf)
  - [noraj][noraj] improved [template](output/examples/OSWE-exam-report-template_noraj_v1.pdf) v1
  - [xl-sec][XL-SEC] improved [template](output/examples/OSWE-exam-report-template_xl-sec_v1.pdf) v1

Exploit Development:

- **OSED**
  - [Official Offensive Security Template v1](output/examples/OSED-exam-report-template_OS_v1.pdf)
  - [epi][epi] improved [template](output/examples/OSED-exam-report-template_epi_v1.pdf) v1
- **OSEE**
  - [Official Offensive Security Template v1](output/examples/OSEE-exam-report-template_OS_v1.pdf)
- **OSCE** (**deprecated**)
  - [Official Offensive Security Template v1](output/examples/OSCE-exam-report-template_OS_v1.pdf)
- **OSMR**
   - [Official Offensive Security Template v1](output/examples/OSMR-exam-report-template_OS_v1.pdf)

Security Operations:

- **OSDA**
  - [Official Offensive Security Template v1](output/examples/OSDA-exam-report-template_OS_v1.pdf)

Threat Hunting:

- **OSTH**
  - [Official Offensive Security Template v1](output/examples/OSTH-exam-report-template_OS_v1.pdf)

Incident Response:

- **OSIR**
  - [Official Offensive Security Template v1](output/examples/OSIR-exam-report-template_OS_v1.pdf)

[whoisflynn]:https://github.com/whoisflynn
[noraj]:https://github.com/noraj
[epi]:https://github.com/epi052
[xl-sec]:https://github.com/xl-sec
[ceso]:https://github.com/ceso

Offensive Security course table:

Exam acronym | Exam name                                         | Lab acronym | Lab name                                   | Course designation
-------------|---------------------------------------------------|-------------|--------------------------------------------|-------------------
**OSCP**     | Offensive Security Certified Professional         | PWK         | Penetration Testing with Kali Linux        | PEN-200
**OSWP**     | Offensive Security Wireless Professional          | WA          | Wireless Attacks                           | PEN-210
**OSEP**     | Offensive Security Experienced Penetration Tester | ETBD        | Evasion Techniques and Breaching Defenses  | PEN-300
**OSWA**     | Offensive Security Web Assessor                   | WAKL        | Web Attacks with Kali Linux                | WEB-200
**OSWE**     | Offensive Security Web Expert                     | AWAE        | Advanced Web Attacks and Exploitation      | WEB-300
**OSED**     | Offensive Security Exploit Developer              | WUMED       | Windows User Mode Exploit Development      | EXP-301
**OSMR**     | Offensive Security macOS Researcher               | MCB         | macOS Control Bypasses                     | EXP-312
**OSEE**     | Offensive Security Exploitation Expert            | AWE         | Advanced Windows Exploitation              | EXP-401
**OSCE**     | Offensive Security Certified Expert               | CTP         | Cracking the Perimeter                     | N/A
**OSDA**     | Offensive Security Defense Analyst                | SODA        | Security Operations and Defensive Analysis | SOC-200
**OSTH**     | Offensive Security Threat Hunting                 | TH          | Threat Hunting                             | TH-200
**OSIR**     | Offensive Security Incident Response              | IR          | Incident Response                          | IR-200

## Community projects

Docker containers:

- [ret2src docker](https://github.com/ret2src/OSCP-Exam-Report-Template-Markdown#docker)
- [Tripex48 docker](https://github.com/Tripex48/OSCP-Exam-Report-Template-Markdown#docker)

## Mentions

- John Hammond - OSCP - Taking Notes & Resources (video) (2019-10-06)
  [![OSCP - Taking Notes & Resources](http://img.youtube.com/vi/MQGozZzHUwQ/0.jpg)](https://www.youtube.com/watch?v=MQGozZzHUwQ)
- John Hammond - OSEP - Offensive Security Experienced Penetration Tester (video) (2021-02-05)
  [![OSEP - Offensive Security Experienced Penetration Tester](https://i.ytimg.com/vi/iUPyiJbN4l4/maxresdefault.jpg)](https://www.youtube.com/watch?v=iUPyiJbN4l4)
- 3rd [Top Offensive Security Open Source Projects](https://awesomeopensource.com/projects/offensive-security) (2022-01-27)
- Recent mentions on social medias: [Social-searcher](https://www.social-searcher.com/social-buzz/?q5=https%3A%2F%2Fgithub.com%2Fnoraj%2FOSCP-Exam-Report-Template-Markdown)
- Articles:
  - [Unofficial OSCP Approved Tools](https://falconspy.medium.com/unofficial-oscp-approved-tools-b2b4e889e707) by FalconSpy (2019-06-05)
  - [Journey from nothing to OSCP](https://cjhackerz.net/posts/journey-from-nothing-to-oscp/) by CJHackerz (2020-06-30)
  - Stress-free OSCP report making by Craig Underhill (2020-04-06) ([Raw Archive](https://web.archive.org/web/20210729100632/https://craigunder.me/stress-free-oscp-report-making/), use `about:reader?url=` for better look in Firefox)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown.svg)](https://starchart.cc/noraj/OSCP-Exam-Report-Template-Markdown)

## Credits

Report Templates:

- **OSCP**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360040165632#suggested-documentation-templates) (UNLICENSED)
  - [whoisflynn improved template](https://github.com/whoisflynn/OSCP-Exam-Report-Template) (UNLICENSED)
- **OSWE**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360046869951-OSWE-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
  - [noraj improved template](src/OSWE-exam-report-template_noraj_v1.md) (UNLICENSED)
  - [XL-SEC improved template](src/OSWE-exam-report-template_xl-sec_v1.md) (UNLICENSED)
- **OSCE**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360046801331-OSCE-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
- **OSEE**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360046458732-OSEE-Exam-Guide#Documentation%20Requirements) (UNLICENSED)
- **OSWP**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360046904731-OSWP-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
- **OSED**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360052977212-OSED-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
  - [epi improved template](src/OSED-exam-report-template_epi_v1.md) (UNLICENSED)
- **OSEP**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/360050293792-OSEP-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
  - [ceso improved template](src/OSEP-exam-report-template_ceso_v1.md) (UNLICENSED)
- **OSWA**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/4410105650964-OSWA-Exam-Guide#suggested-documentation-templates) (UNLICENSED)
- **OSDA**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/4410105675412-OSDA-Exam-Guide#h_01GGD1AKE9DRDAJZ91PXZ5X0PN) (UNLICENSED)
- **OSMR**
  - [Official Offensive Security Template](https://help.offensive-security.com/hc/en-us/articles/4411107766804-OSMR-Exam-Guide#OSMRExamGuide-SuggestedDocumentationTemplates) (UNLICENSED)
- **OSTH**
  - [Official Offensive Security Template](https://help.offsec.com/hc/en-us/articles/29141776768148-OSTH-Exam-Guide-Newly-Updated#h_01J971XAJKYDA6GX24S4XVSBAK) (UNLICENSED)
- **OSIR**
  - [Official Offensive Security Template](https://help.offsec.com/hc/en-us/articles/30960007786900-OSIR-Exam-Guide#h_01JBF3KK3D67Y4SA2PQ5QHTHY1) (UNLICENSED)

Pandoc Template:

- Eisvogel ([LICENCE](https://github.com/Wandmalfarbe/pandoc-latex-template/blob/master/LICENSE)): https://github.com/Wandmalfarbe/pandoc-latex-template

Placeholder image:

- Generated by https://imgplaceholder.com/
