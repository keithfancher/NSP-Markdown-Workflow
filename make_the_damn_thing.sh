#!/bin/bash

# pandoc to convert from markdown to TeX, then my "nspify" script to make the
# TeX a little bit more friendly to the nostarch package.
echo "% this is automatically generated, don't mess with it" > chapter_list.tex
for f in *.txt
do
  # convert to TeX
  outfile=`echo ${f} | sed 's/.txt/.tex/'`
  pandoc -o ${outfile} --chapters ${f}

  # nspify the TeX
  sed -f nspify.sed <${outfile} >${outfile}.tmp
  mv -f ${outfile}.tmp ${outfile}

  # include all chapters in chapter_list
  echo "\input{${outfile}}" >> chapter_list.tex
  mv -f ${outfile} output
done
mv chapter_list.tex output

# build the PDF
cd output
pdflatex book.tex
cp book.pdf ..
cd ..
