## LaTeX Error: Too deeply nested

Related issue and PR by [RMPR](https://github.com/RMPR):
[#3](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/issues/3),
[!2](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/pull/2)

Workaround:

Create `deeplists.tex` file for example for 9 heading levels:

```tex
   \usepackage{enumitem}
   \setlistdepth{9}

   \setlist[itemize,1]{label=$\bullet$}
   \setlist[itemize,2]{label=$\bullet$}
   \setlist[itemize,3]{label=$\bullet$}
   \setlist[itemize,4]{label=$\bullet$}
   \setlist[itemize,5]{label=$\bullet$}
   \setlist[itemize,6]{label=$\bullet$}
   \setlist[itemize,7]{label=$\bullet$}
   \setlist[itemize,8]{label=$\bullet$}
   \setlist[itemize,9]{label=$\bullet$}
   \renewlist{itemize}{itemize}{9}

   \setlist[enumerate,1]{label=$\arabic*.$}
   \setlist[enumerate,2]{label=$\alph*.$}
   \setlist[enumerate,3]{label=$\roman*.$}
   \setlist[enumerate,4]{label=$\arabic*.$}
   \setlist[enumerate,5]{label=$\alpha*$}
   \setlist[enumerate,6]{label=$\roman*.$}
   \setlist[enumerate,7]{label=$\arabic*.$}
   \setlist[enumerate,8]{label=$\alph*.$}
   \setlist[enumerate,9]{label=$\roman*.$}
   \renewlist{enumerate}{enumerate}{9}
```

And add `-H deeplists.tex` option to pandoc CLI when generating the PDF.

## How to put images in my report?

Example:

```md
![ImgPlaceholder](img/placeholder-image-300x225.png)
```

The path can be:

- any absolute path
- relative from the working directory
- relative from `./src` folder
- relative from `/usr/share/osert/src` folder
- relative from any (relative or absolute) path you provide with `--resource-path`, e.g. `ruby osert.rb generate -r /tmp/mycert`

For possible options, see [pandoc options](https://pandoc.org/MANUAL.html#general-options).

## Syntax highlight style ignored when no language provided

https://github.com/jgm/pandoc/issues/6104

Puts `default` as a language for all code blocks which don't have a language set.

E.g.

~~~md
```default
raw code
```
~~~

## How do I know what markdown formatting is supported (there are so many different version)?

In `osert.rb`, `markdown` [is used](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/blob/50aeada2b6171c3a4fe96d91a10f632d752063f2/generate.rb#L82-L93) as `--to` formatter for `pandoc` which means it will use [Pandoc markdown](https://pandoc.org/MANUAL.html#pandocs-markdown) (similar to GFM [[1](https://docs.gitlab.com/ee/user/markdown.html)] [[2](https://github.github.com/gfm/)].) Else other syntaxes (commonmark, GFM, MultiMarkdown, PHP Markdown Extra) are supported too, see [pandoc options](https://pandoc.org/MANUAL.html#option--to). If you want to use another syntax you can generate your report using the [manual command](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown#manual).

## Why very long lines in code blocks overflow the page?

The longest recommended line length in code blocks is 126 characters for the first
line and then 122 characters for the following lines. This is because of limitations
in pandoc that doesn't break very long lines, such as Base64 blobs that easily
get very long. The easiest thing to do is to include a space at these points.

Issue tracking:

- this project: [#21](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/issues/21)
- upstream: [#122](https://github.com/Wandmalfarbe/pandoc-latex-template/issues/122)

A workaround is to prepare the markdown file with with a script (ex: [awk script](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/discussions/66)) to hard wrap lines on code blocks yourself. It's like adding newlines manually but automatically.

## What is the list of supported languages for code blocs syntax highlight?

Pandoc supports [those languages](https://github.com/jgm/pandoc-highlight/blob/master/Text/Pandoc/Highlighting.hs#L93),
to list them you can use `pandoc --list-highlight-languages`.

XL-SEC made a one-liner to quickly generate a dummy code block for each language:

```zsh
$ (for f in $(pandoc --list-highlight-languages); do echo "\`\`\`$f"; echo '$ echo "some output from '$f'"'; echo "some output from $f"; echo "# whoami"; echo "root"; echo "\`\`\`"; echo ""; done;) > highlight-languages.md
```

Then testing all syntax highlight styles for all languages:

```zsh
$ for s in $(pandoc --list-highlight-styles); do pandoc --template eisvogel --highlight-style $s -o highlight-$s.pdf highlight-languages.md; done;
```

## Why are my images formatted in the wrong locations?

This is a [known and open issue with pandoc](https://github.com/jgm/pandoc/issues/845). A simple hack is to create a file called `disable_float.tex` with the following content:

```latex
\usepackage{float}
\let\origfigure\figure
\let\endorigfigure\endfigure
\renewenvironment{figure}[1][2] {
    \expandafter\origfigure\expandafter[H]
} {
    \endorigfigure
}
```

Then add `-H path/to/disable_float.tex` to your `pandoc` command when rendering the report. This will force `pandoc` to render the images in the order that they appear in the original Markdown file while also preserving their captions. [Source](http://stackoverflow.com/a/33801326/1407737).

## How to highlight changes made to exploit code?

When Offensive Security says you have to highlight the changes you made to the exploit, they mean you have to show / explain what you changed in the code but your are free to choose how to do that.

Unfortunately, unlike [AsciiDoc](https://docs.asciidoctor.org/asciidoc/latest/verbatim/highlight-lines/), Markdown is more limited and doesn't allow highlighting a line in a code block.

Alternatively what you can do is:

1. Take a screenshot and add a red rectangle and arrows, then include the image in Markdown
2. Make a diff between the original exploit and the one you modified, then create a code block with `diff` as a language for syntax highlight
3. Write paragraphs and illustrate with short code blocks including the lines you changed
4. Using a more complex solution with Lua filters to introduce a markup for line highlight, e.g. https://github.com/jgm/pandoc/issues/7743

About option 2.:

File `nota.a`:

```text
Hi,

I am noraj.

I hope you enjoy writing your report.

Cheers,

noraj
```

File `note.b`:

```text
Hello,

I am the great noraj.

I wish you a good reporting time.

Regards,

noraj
```

Command: `diff -u note.a note.b`

Output of the command formated into a Markdown fenced code block with `diff` language class:

~~~text
```diff
--- toto.a      2024-07-16 01:18:09.234602615 +0200
+++ toto.b      2024-07-16 01:18:55.269563085 +0200
@@ -1,9 +1,9 @@
-Hi,
+Hello,
 
-I am noraj.
+I am the great noraj.
 
-I hope you enjoy writing your report.
+I wish you a good reporting time.
 
-Cheers,
+Regards,
 
 noraj
```
~~~

Display of the rendered diff code block:

```diff
--- toto.a      2024-07-16 01:18:09.234602615 +0200
+++ toto.b      2024-07-16 01:18:55.269563085 +0200
@@ -1,9 +1,9 @@
-Hi,
+Hello,
 
-I am noraj.
+I am the great noraj.
 
-I hope you enjoy writing your report.
+I wish you a good reporting time.
 
-Cheers,
+Regards,
 
 noraj
```

## Error generating PDF with backslash

Related to [this issue](https://github.com/noraj/OSCP-Exam-Report-Template-Markdown/issues/58).

Due to using Pandoc and a LaTeX template for formating the report, raw backslash (`\`) are interpreted as a control sequence for LaTeX commands.

So if your markdown report contains some plain backslash, you'll get an error like below:

```md
NT AUTHORITY\SYSTEM
```

```
➜ pandoc test.md -o test.pdf --from markdown+yaml_metadata_block+raw_html --template eisvogel
Error producing PDF.
! Undefined control sequence.
l.314 I am NT AUTHORITY\SYSTEM
```

There are two solutions:

1. Put it in markdown code
2. Escape it

### Solution n°1: Markdown code

~~~md
`AUTHORITY\SYSTEM`

```
AUTHORITY\SYSTEM
```
~~~

### Solution n°2: Escaping

```md
NT AUTHORITY\\SYSTEM
```
