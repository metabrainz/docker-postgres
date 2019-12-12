.PHONY: all build

all: build

IMAGE_NAME:=12

build:
	docker build -t metabrainz/postgres-master:$(IMAGE_NAME) postgres-master/
