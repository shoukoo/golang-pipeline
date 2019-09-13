
ver:
	@read -p "Enter a new version:" version; \
	old_version=$(shell grep -o "\d.\d.\d" Dockerfile);  \
	echo "$$old_version to $$version"; \
	for i in $(shell find . -name "Dockerfile"); do sed -i "s/$$old_version/$$version/g" $$i; done;

install:
	

test: 
	go test ./...


.PHONY: ver
