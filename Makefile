.PHONY: all clean lint lint-lacheck lint-chktex

OUT_PDFS = website.pdf nolinks.pdf cv.pdf

all: $(OUT_PDFS)

%.pdf: build/%.pdf
	cp -f build/$*.pdf .

build/%.pdf: cv.tex
	@mkdir -p $(@D)
	pdflatex -output-directory=build -halt-on-error -jobname=$* $< < /dev/null

clean:
	rm $(OUT_PDFS)

lint: lint-lacheck lint-chktex

lint-lacheck:
	lacheck *.tex

lint-chktex:
	chktex -q -n1 -n8 -n12 *.tex
