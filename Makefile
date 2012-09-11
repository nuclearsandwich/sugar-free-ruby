sugarfree.pdf: sugarfree.tex beamerthemesugarfree.sty
	xelatex -shell-escape sugarfree || exit 1

clean:
	rm sugarfree.{log,aux,toc,pdf}

.PHONY: clean
