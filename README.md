## AWS EC2 SSM setup

This infra allows you to provision EC2 and its networking and security components
that can be accessed via AWS SSM. This repository serve the purpose of supporting the video
in youtube [here](https://youtu.be/FNeGnYC6ZN0)

### Requirements
- AWS CLI
- Terraform
- AWS SSM Agent

### Running

```shell
terraform plan
terraform apply
```

### Cleanup

```shell
terraform destroy -auto-approve
```
