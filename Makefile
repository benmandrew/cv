.PHONY: all

all: website.pdf cv.pdf

%.pdf: build_dir build/%.pdf
	mv build/$*.pdf .

build/%.pdf: cv.tex build_dir
	pdflatex -output-directory=build -jobname=$* $<

build_dir:
	mkdir -p build
