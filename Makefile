NAME ?= cray-kafka-operator
CHART_PATH ?= kubernetes
CHART_VERSION ?= local

HELM_IMAGE ?= artifactory.algol60.net/docker.io/alpine/helm:3.7.1
HELM_UNITTEST_IMAGE ?= quintush/helm-unittest:3.3.0-0.2.5

all : chart
chart: chart_setup chart_package chart_test


chart_setup:
		mkdir -p ${CHART_PATH}/.packaged

helm:
	docker run --rm \
	    --user $(shell id -u):$(shell id -g) \
	    --mount type=bind,src="$(shell pwd)",dst=/src \
	    -w /src \
	    -e HELM_CACHE_HOME=/src/.helm/cache \
	    -e HELM_CONFIG_HOME=/src/.helm/config \
	    -e HELM_DATA_HOME=/src/.helm/data \
	    $(HELM_IMAGE) \
	    $(CMD)

chart-package: ${CHART_PATH}/.packaged/${NAME}-${CHART_VERSION}.tgz

${CHART_PATH}/.packaged/${NAME}-${CHART_VERSION}.tgz: ${CHART_PATH}/.packaged
	CMD="dep up ${CHART_PATH}/${NAME}" $(MAKE) helm
	CMD="package ${CHART_PATH}/${NAME} -d ${CHART_PATH}/.packaged" $(MAKE) helm

${CHART_PATH}/.packaged:
	mkdir -p ${CHART_PATH}/.packaged

chart_test:
		helm lint "${CHART_PATH}/${NAME}"
		docker run --rm -v ${PWD}/${CHART_PATH}:/apps ${HELM_UNITTEST_IMAGE} -3 ${NAME}
