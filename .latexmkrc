#!/bin/env perl

$pdf_previewer = 'bash -c "if [[ $(uname -s) == Darwin ]]; then open -a sioyek %O %S; else sioyek %O %S; fi"';

# PDF-generating modes are:
# 1: pdflatex, as specified by $pdflatex variable (still largely in use)
# 2: postscript conversion, as specified by the $ps2pdf variable (useless)
# 3: dvi conversion, as specified by the $dvipdf variable (useless)
# 4: lualatex, as specified by the $lualatex variable (best)
# 5: xelatex, as specified by the $xelatex variable (second best)
$pdf_mode = 4;

# Show used CPU time. Looks like: https://tex.stackexchange.com/a/312224/120853
$show_time = 1;

# Output directory
$out_dir = "build";

# Also remove extra files on clean
# $clean_ext = 'pdfsync synctex.gz';
push @generated_exts, 'synctex.gz';
push @generated_exts, 'listing', 'nav', 'snm', 'vrb';

# --shell-escape option (execution of code outside of latex) is required for the
#'svg' package.
# It converts raw SVG files to the PDF+PDF_TEX combo using InkScape.
#
# SyncTeX allows to jump between source (code) and output (PDF) in IDEs with support
# (many have it). A value of `1` is enabled (gzipped), `-1` is enabled but uncompressed,
# `0` is off.
# Testing in VSCode w/ LaTeX Workshop only worked for the compressed version.
# Adjust this as needed. Of course, only relevant for local use, no effect on a remote
# CI pipeline (except for slower compilation, probably).
#
# %O and %S will forward Options and the Source file, respectively, given to latexmk.
#
# `set_tex_cmds` applies to all *latex commands (latex, xelatex, lualatex, ...), so
# no need to specify these each. This allows to simply change `$pdf_mode` to get a
# different engine. Check if this works with `latexmk --commands`.
&set_tex_cmds("-shell-escape -synctex=1 -interaction=nonstopmode -halt-on-error --file-line-error %O %S");
