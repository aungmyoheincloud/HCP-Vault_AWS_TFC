
# vault enable aws(secrect engine type)
vault secrets enable -path=hellocloud-aws-master-account aws

/config/root Post Method
vault write
# Vault configure to connect to AWS -path=hellocloud-aws-master-account aws #post type(vault write)
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ASSCESS_KEY=

vault write hellocloud-aws-master-account/config/root \ 
access_key=$AWS_ACCESS_KEY_ID \
secret_key=$AWS_SECRET_ASSCESS_KEY \
region=ap-southeast-1


At present,the endpoint(hellocloud-aws-master-account/config/root) does not confirm that provided AWS credentials are valid 

# vault read hellocloud-aws-master-account/config/root (get)
 
# aws/config/rotate-root (Post)
vault write -f hellocloud-aws-master-account/config/rotate-root
Note: Vault will now be the only entity that knows the AWS secret key is used to access AWS.

# static-role(/aws/static-roles/:name) POST/GET
Note: A static role is a 1-to-1 mapping with an AWS IAM User
https://developer.hashicorp.com/vault/api-docs/secret/aws#create-update-static-role

# vault write
vault write hellocloud-aws-master-account/static-roles/master-vpc-vault-static-role \
username=master-vpc-vault-static-role \
rotation_period=10m

NOTE: At this situration, there is no access key and secret key in master-vpc-vault-static-role iam user, but vault automatically created the access key and secret key for iam user which mapped with vault.

# vault read
vault read hellocloud-aws-master-account/static-roles/master-vpc-vault-static-role

<!-- # config aws for that iam user
vi ~/.aws/confgi
vi ~/.aws/credentials -->

# write terraform code

https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/aws_static_credentials


terraform output master-vpc-vault-static-user-creds


# Don't user local backend because keep the access key and secrtes key in tf.state in locally. So it should be kept in TF Cloud