#!/bin/zsh

#Small script to check the ECS services version. The region should be passed as a parameter.


source ~/.zshrc

all_clusters="$(aws ecs list-clusters --region $1 --query 'clusterArns' --output text)"
echo $all_clusters
all_services="$(for ecscluster in $all_clusters; do aws ecs list-services --region $1 --cluster $ecscluster --output text; done)"
all_services=$(echo $all_services | cut -f2)
echo $all_services
all_versions="$(for service in $all_services; do aws ecs describe-services --region $1 --cluster $all_clusters --services $all_services --query 'services[*].platformVersion'; done)"
echo $all_versions

# all_versions="$(for ecsservices in $(for ecscluster in $(aws ecs list-clusters --region $1 --query 'clusterArns' --output text); do aws ecs list-services --region $1 --cluster $ecscluster --output text; done); do aws ecs describe-services --region $1 --cluster $ecscluster --services $ecsservices; done)"
# echo $ecscluster
# echo $ecsservices
# echo $all_versions