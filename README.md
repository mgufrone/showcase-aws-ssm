## AWS EC2 SSM setup

This infra allows you to provision EC2 and its networking and security components
that can be accessed via AWS SSM. This repository serve the purpose of supporting the video
in youtube [here](https://youtu.be/BzVwZ_TnOpo)

### Requirements
- AWS CLI
- Terraform
- AWS SSM Agent

### Before Running

Update `locals.tf` to adjust based on the resources you have. Either that, or you can create your own VPC, Public Subnet, and Route Tables


### Running

```shell
terraform plan
terraform apply
```

### Cleanup

```shell
terraform destroy -auto-approve
```
