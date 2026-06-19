IMAGE_NAME = cv-builder
SRC_MD = src/cv.md
TEMPLATE = src/template.html
CSS = assets/style.css
OUTPUT = cv.pdf

.PHONY: all build clean

all: build

build:
	docker build -t $(IMAGE_NAME) .
	docker run --rm -v $(PWD):/workspace $(IMAGE_NAME) \
		$(SRC_MD) \
		--template=$(TEMPLATE) \
		--css=$(CSS) \
		--pdf-engine=weasyprint \
		-o $(OUTPUT)
	@echo "Succès ! Le CV a été généré localement sous le nom de : $(OUTPUT)"

clean:
	rm -f $(OUTPUT)
	@echo "Fichier local nettoyé."