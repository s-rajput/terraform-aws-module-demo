# terraform-aws-module-demo
##### This project is a quick demonstration of test-driven development in infra-as-code using Terraform and TerraTest in Golang.
##### All infra-as-code projects must have a CICD pipeline with a pull-request automation workflow for ex: Atlantis for Terraform.
##### This repository contains a terraform module that will provision underline resources required to run neptune cluster in AWS. 
#####  An example folder contains code example to show how to use the module in projects.

##### This module that will provision resources to perform these steps:
##### 1. Create a VPC
##### 2. Create a rule for outbound internet access so request can go out
##### 3. Create the public subnet for availability zone a and b.
##### 4. Create neptune subnet group and assign above 2 public subnets to it. (Always use private subnets in prod*)
##### 5. Create a neptune cluster
##### 6. Create a neptune instance
##### 7. Create custom endpoints (reader/writer)
##### 8. Create an EC2 instance for connection to neptune via bastion
##### 9. Create security groups to enable bastion access 

