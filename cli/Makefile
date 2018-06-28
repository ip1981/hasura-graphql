PWD := $(shell pwd)
PARENT_DIR := $(shell dirname $(PWD))
VERSION := $(shell build/get-version.sh)
OUTPUT_DIR := _output

.PHONY: build test clean assets all docs

# compile assets
assets:
	go-bindata --pkg assets -o assets/assets.go assets/console.html

# get dependencies
deps:
	go get github.com/golang/dep/cmd/dep
	go get github.com/mitchellh/gox
	go get github.com/hasura/go-bindata/go-bindata
	dep ensure

# build cli locally, for all given platform/arch
build:
	gox -ldflags "-X github.com/hasura/graphql-engine/cli.version=$(VERSION)" \
	-os="linux darwin windows" \
	-arch="amd64" \
	-output="$(OUTPUT_DIR)/$(VERSION)/hasura-{{.OS}}-{{.Arch}}" \
	./cmd/hasura/

# run tests
test:
	go test ./...

# generate docs
docs:
	rm -fr docs
	go run cmd/hasura/hasura.go docs --type md --directory docs

# clean the output directory
clean:
	rm -rf "$(OUTPUT_DIR)"

all: deps assets test build

# build cli inside a docker container
all-in-docker:
	docker build -t hasura-graphql-cli-builder -f build/builder.dockerfile build
	docker run --rm -it \
	-v $(PARENT_DIR):/go/src/github.com/hasura/graphql-engine \
	hasura-graphql-cli-builder \
	make all