# tf-cloudflare

## Simple Terraform configuration to create the following resources:

- CloudFlare    DNS Zone;
- CloudFlare    DNS Records;
- AWS           S3 bucket (to store TF state);
- AWS           S3 acl (to keep the bucket private);
- AWS           S3 Versioning (speaks for itself right?);
- AWS           DynamoDB (to prevent write operations while another is already ongoing);

### Prerequisites:

- CloudFlare account (free plan will do);
- AWS account:
-> S3 (to store just the tf state file, S3 will cost less than 1 cent a month);
-> DynamoDB (AWS offers 25GB of storage FOREVER);

To generate your CloudFlare API Key access, if you don't already have one:
https://dash.cloudflare.com/profile/api-tokens

### How to use:

1. Setup tf variables, if you are running this locally i recommend to create a `terraform.tfvars` and put this:

```
domain                  = "<your-domain>"
cloudflare_email        = "<your-cloudflare-email-account>"
cloudflare_api_key      = "<your-cloudflare-generated-api-key>"
```

2. Assuming that you have already configured your AWS access credentials, Initialize Terraform to start downloading Providers (CloudFlare and AWS) and Setup S3 and DynamoDB as Backend:

`$ terraform init`

3. Plan and Appply your code:

`$ terraform plan && terraform apply --auto-approve`

4. See the resources created:

`$ terraform show`

5. Destroy all resources created previously:

`$ terraform destroy --auto-approve`

