#!/bin/sh
# if .env file exists, export all variables
if [ -f .env ]; then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

echo "Preparing env"


echo "checking if AWS_REGION is set..."
if [ -z "$AWS_REGION" ]; then
  echo "AWS_REGION is not set"
  exit 1
fi


echo "checking if CLUSTER_NAME is set..."
if [ -z "$CLUSTER_NAME" ]; then
  echo "CLUSTER_NAME is not set"
  exit 1
fi

# show the current CLUSTER_NAME and if the user dont want to continue, exit
echo "CLUSTER_NAME is set to $CLUSTER_NAME"
read -p "Do you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi
# check if aws cli client secret is set
if [ -z "$AWS_REGION" ]; then
  echo "AWS_REGION is not set"
  exit 1
fi
# add created cluster to kubeconfig
echo "adding cluster to kubeconfig..."
aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME
echo "Cluster added to kubeconfig successfully!"

