# Cucumber HTML Reporter

The Cucumber HTML Reporter generates Human-friendly rendering of the JSON results of a Cucumber or Godog test run.

The CHR is a wrapper which unplugs, 12-factors and containerises the [node.js reporting plugin](https://github.com/gkushang/cucumber-html-reporter) for Cucumber.

## Usage
For building or pushing the image, you must supply a Docker registry location via the REGISTRY environment variable.

The supplied Makefile demonstrates how to build, test and publish the container:

* `make chr-build # builds image locally`
* `make chr-clear # wipes local image`
* `make chr-run   # runs image locally`
* `make chr-test  # runs and fails if no output`
* `make chr-push  # pushes local image to artifactory`

### Parameters

The container must be given volumes mapping to the container's `/use/src/app/in` and `/use/src/app/out` for reading one or more input JSON files and writing the output HTML file. 

The Docker image tag can be specified by setting the TAG environment variable, eg `TAG=latest make chr-build`. The value for this tag defaults to 'dev'.

The container can be configured using environment variables, using a [12 Factor Node module](https://github.com/whynotsoluciones/node-env-configuration). For options and defaults see [main.js](main.js).

For example `CHR_APP_jsonFile` and `CHR_APP_output` specify the names of the input and output files (defaulting to `in/report.json` and `out/report.html` respectively), as illustrated by `make chr-run`:

````[make]
chr-run:
	docker run --rm news \
		-e "CHR_APP_output=out/report.html" \
		-v $(shell pwd)/data:/use/src/app/in \
		-v $(shell pwd)/data:/use/src/app/out \
        -e "CHR_APP_metadata_<key>=<value>" \
		$(REPO)/$(APP):$(TAG)
````

## Contributors

Created by the Intelligent Environments Product Development team.
