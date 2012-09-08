sugarfree.pdf: sugarfree.tex beamerthemesugarfree.sty
	xelatex -shell-escape sugarfree || exit 1
	xelatex -shell-escape sugarfree || exit 2

clean:
	rm sugarfree.{log,aux,toc,pdf}

.PHONY: clean
