#!/bin/bash

kubectl create -f ../configmap/order-service-config.yaml
kubectl create -f ../configmap/payment-service-config.yaml
kubectl create -f ../configmap/product-service-config.yaml
kubectl create -f ../configmap/mysql-config.yaml

kubectl create -f ../services/mysql-service.yaml
kubectl create -f ../services/order-service-service.yaml
kubectl create -f ../services/payment-service-service.yaml
kubectl create -f ../services/product-service-service.yaml

kubectl create -f ../deployment/order-service-deployment.yaml
kubectl create -f ../deployment/payment-service-deployment.yaml
kubectl create -f ../deployment/product-service-deployment.yaml
kubectl create -f ../deployment/mysql-deployment.yaml

