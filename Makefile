.PHONY: all clean lint

OUT_PDFS = website.pdf nolinks.pdf cv.pdf

all: $(OUT_PDFS)

cv.pdf: cv.typ
	typst compile $< $@

website.pdf: cv.typ
	typst compile --input variant=website $< $@

nolinks.pdf: cv.typ
	typst compile --input variant=nolinks $< $@

clean:
	rm -f $(OUT_PDFS)

# Compiling surfaces Typst's own warnings (unresolved refs, unknown fonts, etc.)
lint:
	typst compile -f pdf cv.typ /dev/null
	typst compile -f pdf --input variant=website cv.typ /dev/null
	typst compile -f pdf --input variant=nolinks cv.typ /dev/null
