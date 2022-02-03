 

module "neptunedb" {

source = "../../neptunedb"
neptune_name = "srneptune"
neptune_sg_name = "sr-securitygroup1"
#neptune_count=2


# channel = "srchnl"
# apply_immediately= false
# copy_tags_to_snapshot= false
# deletion_protection= false
# engine= "neptune"
# engine_version= "8.0.16"
# identifier= "avro-dev-integration-contentful-adapter-cluster"
# instance_type= "db.t3.small"
# parameter_group_family= "mysql8.0"
# parameter_group_name= "rds-param-group-sho-dev-mysql-shared-1"
# parameters= []
# resource_tags_rds_instance:
#   qantas:gorillastack:schedule: "business-hours-standard"
# security_group_name: "sec-sho-dev-mysql-shared-1"
# subnet_group_name: "rds-subnet-group-sho-dev-mysql-shared-1"
# use_custom_parameter_group: true

}

 
