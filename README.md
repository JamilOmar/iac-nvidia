

## Requirements
- Aws Account
- Aws Cli Installed
- [Eksctl](https://docs.aws.amazon.com/emr/latest/EMR-on-EKS-DevelopmentGuide/setting-up-eksctl.html) 
- Terraform Cli
- Kubernetes Cli
- helm charts
- mkcert

Run the following terraform projects in order.

### Global
[Backend Creation](/terraform/aws/global/README.md)

### VPC

[VPC Creation](/terraform/aws/vpc/README.md)

### EKS

[Cluster Creation](/terraform/aws/cluster/README.md)


### Omniverse 

[Omniverse Instance](/terraform/aws//ovw-instance/README.md)


### Next Steps Connect with MFE Project

[MicroFrontEnds and Microservices Architecture](https://github.com/JamilOmar/mfe-template)

MIT