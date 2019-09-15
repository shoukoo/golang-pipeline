
ver:
	@read -p "Enter a new version:" version; \
	old_version=$(shell grep -o "\d.\d.\d" Dockerfile);  \
	echo "$$old_version to $$version"; \
	for i in $(shell find . -name "Dockerfile"); do sed -i "s/$$old_version/$$version/g" $$i; done;

sync:
	cat setup.sh | tee $(shell find . -name "gp-setup.sh")
	cat linter.sh | tee $(shell find . -name "gp-linter.sh")
	cat release.sh | tee $(shell find . -name "gp-release.sh")
.PHONY: ver sync
