DOCKER_IMAGE_VERSION=0.0.1
DOCKER_IMAGE_NAME=lispmeister/ponyc
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag -f $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) echo 'Success.'

version:
	ponyc --version

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
	docker rmi $(docker images -f "dangling=true" -q)

