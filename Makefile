.PHONY: all clean lint

all: website.pdf cv.pdf

%.pdf: build_dir build/%.pdf
	mv -f build/$*.pdf .

build/%.pdf: cv.tex build_dir
	pdflatex -output-directory=build -halt-on-error -jobname=$* $<

build_dir:
	mkdir -p build

clean:
	rm website.pdf cv.pdf

lint:
	lacheck *.tex
