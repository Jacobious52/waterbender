#!/bin/bash

.PHONY: up providers down definitions kube usage

up:
	kind create cluster --name providers
	kind get kubeconfig --name providers > providers.kubeconfig
	KUBECONFIG=providers.kubeconfig up uxp install

kube: providers definitions	usage

providers:
	kubectl --kubeconfig providers.kubeconfig apply -f providers.yaml

definitions:
	kubectl --kubeconfig providers.kubeconfig apply -f definitions.yaml

usage:
	kubectl --kubeconfig providers.kubeconfig apply -f usage.yaml

down:
	kind delete cluster --name providers
	rm providers.kubeconfig
