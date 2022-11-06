As a pre-requisite install packer and ansible on your local machine

For Mac User :

```
brew upgrade
 
# Install Packer:
brew tap hashicorp/tap
brew install hashicorp/tap/packer
 
# And later to upgrade Packer:
brew upgrade hashicorp/tap/packer
```
## Build Packer Image 
We need to tell Packer what base server image we will use to build upon. We're not making a server image from scratch, instead we use our cloud providers base images and build on top of them.

We could simply tell Packer that directly via "source_ami":"ami-07c1207a9d40bc3bd", but we'll instead use a filter to find the latest AMI for our use case.

We'll use the (standard) Packer Builder amazon-ebs. You can see all available builders here.

Here's how you make an AMI in AWS:

Create a server with an EBS root drive
EBS (Elastic Block Storage) are the disk drives in AWS
Install and configure the server however you'd like
Create a snapshot of the EBS root volume
Convert that snapshot to an AMI
Here's what it looks like to have Packer choose AWS server to build upon. We'll ask Packer to use a filter (using the AWS API) to find the latest Ubuntu 20.04 AMI created by Canonical.

```
ANSIBLEPW=`cat .vault`
 
packer build \
    -var "infra_env=staging" \
    -var "vault_pass=$ANSIBLEPW" \
    cloudcasts-app.json
```    
