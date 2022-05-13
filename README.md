# terraform-aws-module-demo
## This repository contains a terraform module that will provision underline resources required to run neptune cluster in AWS.
##  Test folder contains unit tests written in Golang to test the provisioning using Terratest.
##  An example folder contains code example to show how to use the module in projects.

### This module that will provision:
### 1. Create a VPC
### 2. Create a rule for outboung internet access so request can go out
### 3. Create the public subnet for availability zone a and b.
### 4. Create neptune subnet group and assign above 2 public subnets to it. (Always use private subnets in prod*)
### 5. Create a neptune cluster
### 6. Create a neptune instance
### 7. Create custom endpoints (reader/writer)
### 8. Create an EC2 instance for connection to neptune via bastion
### 9. Create security groups to enable bastion access 
