NAME = andreysabitov/impala-kudu
GIT_VERSION := $(shell git describe --abbrev=0 --tags)
ifndef GIT_VERSION
	VERSION = latest
else
	VERSION = $(GIT_VERSION)
endif

.PHONY: all build

all: build tag

build: 
	docker build -t $(NAME) .

tag:
	docker tag $(NAME) $(NAME):$(VERSION)
	docker tag $(NAME):$(VERSION) $(NAME):latest
push: 
	docker push $(NAME):$(VERSION)
	docker push $(NAME):latest

debug: 
	docker run --rm -it $(NAME) /bin/bash

run: 
	docker run --rm $(NAME)

release: build tag push 
