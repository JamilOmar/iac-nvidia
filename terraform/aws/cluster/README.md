### Cluster

This terraform project contains the cluster creation with: 

- 2 Public Subnets
- 2 Private Subnets
- 1 Nat
- 1 ipgw
- Eks Cluster
- 3 Nodes 
- 1 Security Group

- iam oidc
- IRSA for ebs
- IRSA for efs
- IRSA for alb
- IRSA for vpc_cni


### How To Start
- Update the backend information in the terrafor main file.
- In the terraform.tfvars file ( create if not) , you need to set the `vpc_id` value
```sh
    vpc_id="vpc from previous step"
```

The run the terraform commands:

```sh
terraform init
terraform plan
terraform apply
```

You will see your cluster created.