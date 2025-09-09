.PHONY: all clean lint

OUT_PDFS = website.pdf nolinks.pdf cv.pdf

all: $(OUT_PDFS)

%.pdf: build/%.pdf
	cp -f build/$*.pdf .

build/%.pdf: cv.tex
	@mkdir -p $(@D)
	pdflatex -output-directory=build -halt-on-error -jobname=$* $<

clean:
	rm $(OUT_PDFS)

lint:
	lacheck *.tex
