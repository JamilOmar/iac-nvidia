### Global

This terraform project contains the terraform backend creation with: 

- 1 s3 bucket 
- 1 DynamoDb table


### How To Start

- In the terraform.tfvars file ( create if not) , you need to set the `bucket` and `locks_name` values
```sh
    bucket="test1"
    locks_name ="test2_locks"

```
Important, you will need to update the backend information in each of the terrafor main files.
The run the terraform commands:

```sh
terraform init
terraform plan
terraform apply
```

You will see your cluster created.