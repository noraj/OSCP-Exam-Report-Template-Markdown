#!/bin/bash

#written by @initinfosec - 05 JUN 2020
#simple bash script to install/configure necessary setup for noraj PWK/OSCP report md to PDF conversion tool

#only tested on kali 2020.x - error checking/input validation is not thorough

# check if running with sudo
if [[ $EUID -ne 0 ]]; then
	echo -e "Script will need sudo/root privs for portions of the install actions. You may be prompted for your password if installs need to be made.\n\n"
	SUDO='sudo'
fi

# caveat emptor preface

echo -e "This setup script only needs to be run if you have not installed LaTeX, Pandoc, etc. and configured according to https://github.com/initinfosec/OSCP-Exam-Report-Template-Markdown\nThis script was only tested on kali 2020.x\n\n"

read -n1 -rsp "If already configured, press Q to exit script. Otherwise, press any key to continue: " key

if [ "${key,,}" = "q" ]; then
	echo -e "\nExiting.\n" && exit
else
	echo -e "\nContinuing with setup.\n"
fi


# search for 7zip, pandoc, LaTeX full, and eisvogel on system

cwd="$(pwd)"
eisvogelDir="$(pwd)/eisvogel"

if which 7z &> /dev/null ; then
	echo -e "7z detected installed, moving on.\n"
else
	echo -e "7z not detected, installing.\n"
	yes | $SUDO apt install p7zip-full &> /dev/null && echo -e "p7zip-full installed.\n"
fi

if which pandoc &> /dev/null ; then
	echo -e "pandoc detected installed, moving on.\n"
else
	echo -e "pandoc not detected, installing.\n"
	yes | $SUDO apt install pandoc &> /dev/null && echo -e "pandoc installed.\n"

fi

if dpkg -s texlive-full &> /dev/null ; then
	echo -e "LaTeX full detected installed, moving on.\n"
else
	echo -e "LaTeX full not detected, installing.\n"
	yes | $SUDO apt install texlive-full &> /dev/null && echo -e "texlive-full installed.\n"
fi

# search for eisvogel template installed
if locate eisvogel &> /dev/null ; then
	echo -e "eisvogel detected, moving on.\n"
else
	echo -e "eisvogel template not found, installing.\n"
	cd $eisvogelDir
	wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v1.4.0/Eisvogel-1.4.0.tar.gz
	tar xzf Eisvogel-*.tar.gz 2> /dev/null
	mkdir -p ~/.pandoc/templates
	cp eisvogel.tex ~/.pandoc/templates/eisvogel.latex
	echo -e "eisvogel template installed.\n"
	cd $cwd
fi

# finish up
echo -e "\n--------------------------------------------------\n\nSetup script finished. You can now use generate.rb \n\n\nCopy your markdown notes to the template you want to use in ./src/\nLeave the header from the template as-is - the script will interactively prompt for and change header values.\n\n"
