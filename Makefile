.PHONY: all build

all: build

build:
	docker build -t metabrainz/postgres-base -f postgres-base/Dockerfile .
	docker build -t metabrainz/postgres-master -f postgres-master/Dockerfile .
	docker build -t metabrainz/postgres-slave -f postgres-slave/Dockerfile .
