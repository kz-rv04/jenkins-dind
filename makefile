.PHONY: build
.PHONY: up
.PHONY: down
.PHONY: exec
.PHONY: docker

build:
	docker-compose up -d --build

up:
	docker-compose up -d

down:
	docker-compose down -v

exec:
	docker-compose exec jenkins-blueocean /bin/bash

docker:
	sudo service docker start
