.PHONY: all build

all: build

build:
	docker build -t metabrainz/postgres-base postgres-base/
	docker build -t metabrainz/postgres-master postgres-master/
	docker build -t metabrainz/postgres-slave postgres-slave/
