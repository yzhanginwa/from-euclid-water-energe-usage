#!/usr/bin/env bash

function destroy_image() {

}

function destroy_images() {
  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "data-l1" ]]; then
    destroy_container data-l1 "DATA-L1"
    rm -f infra/docker/shared/jars/data-l1.jar
  fi

  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "currency-l1" ]]; then
    destroy_container currency-l1 "CURRENCY-L1"
    rm -f infra/docker/shared/jars/currency-l1.jar
  fi

  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "metagraph-l0" ]]; then
    destroy_container metagraph-l0/genesis "METAGRAPH-L0-GENESIS"
    destroy_container metagraph-l0 "METAGRAPH-L0-VALIDATORS"
    rm -f infra/docker/shared/jars/metagraph-l0.jar
  fi

  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "dag-l1" ]]; then
    destroy_container dag-l1 "DAG-L1"
    rm -f infra/docker/shared/jars/dag-l1.jar
  fi

  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "global-l0" ]]; then
    destroy_container global-l0 "GLOBAL-L0"
    rm -f infra/docker/shared/jars/global-l0.jar
  fi

  if [[ " ${DOCKER_CONTAINERS[*]} " =~ "monitoring" ]]; then
    destroy_container monitoring "MONITORING"
  fi

  destroy_container metagraph-base-image "BASE-IMAGE"
}

function purge_containers() {
  echo_white "Starting purging containers ..."
  destroy_containers
}
