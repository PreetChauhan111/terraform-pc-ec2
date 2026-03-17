# pc-ec2-wrapper

Wrapper module for AWS EC2 Instances.

## Source

This wrapper uses the upstream module from [`terraform-aws-modules/ec2-instance/aws`](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest) version ~> 6.3 and adds local naming, common tags (Owner=pc, GitHubRepo), derived names for SG/key/EIP/IAM, region/environment defaults.

## Usage

```hcl
module "example_ec2" {
  source = "./pc-ec2-wrapper"

  region     = "ap-south-1"
  environment = "dev"
  
  name       = "my-ec2-instance"
  subnet_id  = "subnet-12345678"
  instance_type = "t3.micro"
  
  tags = {
    Purpose = "web"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `create` | Whether to create an instance | `bool` | `true` |
| `name` | Name to be used on EC2 instance created. Auto-generated as pc-ec2-<env>-<region> if empty | `string` | `""` |
| `region` | AWS Region | `string` | `"ap-south-1"` |
| `environment` | Deployment environment | `string` | `"Dev"` |
| `ami` | ID of AMI to use for the instance | `string` | `null` |
| `ami_ssm_parameter` | SSM parameter name for the AMI ID (Amazon Linux AL2023 default) | `string` | `"/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"` |
| `instance_type` | The type of instance to start | `string` | `"t3.micro"` |
| `subnet_id` | The VPC Subnet ID to launch in | `string` | `null` |
| `tags` | A mapping of tags to assign to the resource. Merged with common | `map(string)` | `{}` |
| `vpc_security_group_ids` | A list of security group IDs to associate with | `list(string)` | `[]` |
| `create_security_group` | Determines whether a security group will be created | `bool` | `true` |
| `security_group_name` | Name to use on security group created. Derived as <name>-sg if empty | `string` | `null` |
<!-- Abbreviated; full: spot, iam, ebs, user_data etc. See variables.tf --> |
| `putin_khuylo` | Fun var | `bool` | `true` |

Full inputs: see [variables.tf](variables.tf).

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the instance |
| `arn` | The ARN of the instance |
| `public_ip` | The public IP address assigned to the instance, if applicable |
| `private_ip` | The private IP address assigned to the instance |
| `security_group_id` | ID of the security group |
| `iam_role_arn` | The Amazon Resource Name (ARN) specifying the IAM role (if created) |
<!-- Abbreviated; full list in outputs.tf --> |

## Notes

- Auto-generates names: instance pc-ec2-<env>-<region>, sg <name>-sg, key <name>-key etc.
- Merges user `tags` with common: `{Owner=pc, Environment, GithubRepo=pc-ec2-wrapper, Name}`.
- Default AMI from SSM AL2023, t3.micro.
- Supports Spot instances, IAM profile creation, EBS volumes, custom SG.
- Default region `ap-south-1`, env `Dev`.
- `putin_khuylo=true`.

