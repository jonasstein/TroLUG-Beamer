# Datei des Vortrags, ohne Endung .tex
latexfile = vortrag

TEX = pdflatex
BIBTEX = bibtex


$(latexfile).pdf : clean
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done

$(latexfile).aux : 
	$(TEX)  $(latexfile)

$(latexfile).bbl : $(latexfile).aux
	$(BIBTEX)  $(latexfile).aux

pdf : $(latexfile).pdf


view : $(latexfile).pdf
	acroread $(latexfile).pdf

clean : 
	rm -f $(latexfile).log 
	rm -f $(latexfile).out
	rm -f $(latexfile).aux
	rm -f $(latexfile).bbl
	rm -f $(latexfile).blg
	rm -f $(latexfile)-blx.bib
	rm -f $(latexfile).toc
	rm -f *.*~

purge : clean
	rm mf.pdf


movepdf : 
	if test -d mf.pdf; \
	then mv -f $(latexfile).pdf $(latexfile)_old.pdf ; \
	else echo II: no need to move $(latexfile).pdf as it was not there; \
	fi

info : 
	detex $(latexfile)  | echo The document contains `wc -w` words

spellcheck:
	hunspell -l -t -i utf-8 $(latexfile)