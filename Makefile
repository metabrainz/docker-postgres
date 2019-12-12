.PHONY: all build

all: build

IMAGE_NAME:=9.6

build:
	docker build -t metabrainz/postgres-base:$(IMAGE_NAME) postgres-base/
	docker build -t metabrainz/postgres-master:$(IMAGE_NAME) postgres-master/
	docker build -t metabrainz/postgres-slave:$(IMAGE_NAME) postgres-slave/
