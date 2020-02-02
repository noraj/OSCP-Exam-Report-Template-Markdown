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

```
![ImgPlaceholder](src/placeholder-image-300x225.png)
```

The path is relative from the generating script not from the markdown template!

## Syntax highlight style ignored when no language provided

https://github.com/jgm/pandoc/issues/6104

Puts `default` as a language for all code blocks which don't have a language set.

Eg.

~~~
```default
raw code
```
~~~
