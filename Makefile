help:
	echo "See readme.md"

REG  = $(REGISTRY)
APP  = cucumber-html-reporter
TAG  ?= dev # or pick up env var setting for $TAG if defined, eg 'latest' in TC
IMAGENAME = $(REG)/$(APP):$(TAG)

# target to simply re-run service tests against the current test environment
_test-registry-defined:
	@if test -z "$(REGISTRY)"; then echo "Need env var REGISTRY to provide Docker registry address"; exit 1; fi

chr-build: _test-registry-defined
	docker build -t $(IMAGENAME) .

chr-clear:
	docker rmi $(IMAGENAME)

chr-push: _test-registry-defined
	docker push $(IMAGENAME)

chr-run:
	docker run --rm \
		-e "CHR_APP_output=out/report.html" \
		-v $(shell pwd)/data:/use/src/app/in \
		-v $(shell pwd)/data:/use/src/app/out \
		$(IMAGENAME)

_test-prepare:
	rm -f data/*.html

_test-assert:
	test -f data/*.html # error if not found

chr-test: _test-prepare chr-run _test-assert

