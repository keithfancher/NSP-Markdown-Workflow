#!/bin/bash

echo "% this is automatically generated, don't mess with it" > chapter_list.tex
for f in *.txt
do
  # convert to TeX
  outfile=`echo ${f} | sed 's/.txt/.tex/'`
  pandoc -o ${outfile} --chapters ${f}

  # nspify the TeX
  sed -f nspify.sed <${outfile} >${outfile}.tmp
  mv -f ${outfile}.tmp ${outfile}

  # include chapters in chapter_list
  echo "\input{${outfile}}" >> chapter_list.tex
  mv -f ${outfile} output
done
mv -f chapter_list.tex output

# build the PDF
cd output
pdflatex book.tex
mv -f book.pdf ..
cd ..
