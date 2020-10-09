# Documentation - Create EKS cluster using eksctl

## Prerequisites:

- Install the AWS CLI & Kubectl & eksctl from this [Link](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)


## Bring up Our Cluster:

- Creating the cluster:
```
eksctl create cluster -f eks-capstone-cluster.yaml
```

- Check the cluster:
```
eksctl get cluster --region us-east-2
```
