.PHONY: all clean lint

all: website.pdf cv.pdf

%.pdf: build/%.pdf
	cp -f build/$*.pdf .

build/%.pdf: cv.tex
	@mkdir -p $(@D)
	pdflatex -output-directory=build -halt-on-error -jobname=$* $<

clean:
	rm website.pdf cv.pdf

lint:
	lacheck *.tex
