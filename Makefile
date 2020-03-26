TAG_NAME=proto-jenkins-seed-job
ifndef TAG_VERSION
$(error TAG_VERSION is not set)
endif

build:
	docker build --pull --tag ${TAG_NAME}:latest --tag ${TAG_NAME}:${TAG_VERSION} .

run:
	docker container run -p 8080:8080 -p 50000:50000 --name jenkins ${TAG_NAME}:${TAG_VERSION}
