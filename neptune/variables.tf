# variable "neptune_name" {
#   type        = string
#   default = "neptune-cluster-demo"
# }

# variable "neptune_sg_name" {
#   default = "neptune-sg"
# }

# variable "neptune_count" {
#   default = 2
# }

# variable "engine" {
#   description = "Neptune Engine"
#   type        = string
#   default     = "aurora-mysql"
# }

# variable "env" {
#   description = "AWS Environment, for example - dev, sit, stg, prd... etc"
#   type        = string
# }

# variable "parameters" {
#   description = "Neptune custom parameter"
#   type        = list(map(string))
#   default     = []
# }
 
variable "aws_region" {
  description = "The default region for the AWS Provider"
  type        = string
  default     = "ap-southeast-2"
}

variable "allow_major_version_upgrade" {
  description = "Enable to allow major engine version upgrades when changing engine versions. Defaults to `false`"
  type        = bool
  default     = false
}


variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "backup_window" {
  description = "Specifies the weekly time range for when backup on the Neptune is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC)"
  type        = string
  default     = ""
}

variable "channel" {
  description = "QL Channel code"
  type        = string
}

 
variable "cost_centre" {
  description = "Cost centre of resources"
  type        = string
}
  

variable "engine" {
  description = "Neptune Engine"
  type        = string
  default     = "neptune"
}

variable "engine_version" {
  description = "Specifies the Neptune engine version"
  type        = string
  default     = null
}

variable "env" {
  description = "AWS Environment, for example - dev, sit, stg, prd... etc"
  type        = string
}

variable "identifier" {
  description = "Identifier of Neptune instance"
  type        = string
  default     = null
}

variable "ingress_from_port" {
  description = "From port of Ingress rule"
  type        = number
  default     = null
}

variable "ingress_to_port" {
  description = "To port of Ingress rule"
  type        = number
  default     = null
}

variable "ingress_cidrs" {
  description = "CIDR block that will be added to the security group ingress rule. This value will override the values looked up by ingress_subnet_type"
  type        = list(string)
  default     = []
}

variable "ingress_subnet_type" {
  description = "Subnet type to be added in the Neptune security group rule."
  type        = list(string)
  default     = ["protected"]
}

variable "instance_type" {
  description = "Specifies the instance type of Neptune instance"
  type        = string
  default     = "db.t2.micro"
} 
 
 
variable "parameter_group_name" {
  description = "Name of Neptune parameter group. Provide when use_custom_parameter_group = True"
  type        = string
  default     = ""
}

variable "parameter_group_family" {
  description = "Neptune parameter group family"
  type        = string
  default     = null
}
 
variable "use_custom_parameter_group" {
  description = "Specifies if Neptune required custom parameter group"
  type        = bool
  default     = false
}

variable "parameters" {
  description = "Neptune custom parameter"
  type        = list(map(string))
  default     = []
}

variable "primary_instance_count" {
  description = "instance count for primary Aurora cluster"
  default     = 1
}

variable "qlmgt_account_id" {
  description = "Account ID of qlmgt"
  type        = string
  default     =  "65761673819"
}

variable "Neptune_name" {
  description = "The name of the database used for constructing DB instance identifier, etc."
  type        = string
  default     = "neptune"
}

 

variable "retention_period" {
  description = "Specifies the time range for retention period for Neptune. The retention period is defined in days"
  type        = number
  default     = 30
} 

variable "security_group_name" {
  description = "Name of security group to create for this Neptune instance"
  type        = string
  default     = null
}

 
variable "skip_final_snapshot" {
  description = "Whether a final DB snapshot is created when Neptune instance is deleted"
  type        = bool
  default     = true
}

variable "snapshot_identifier" {
  description = "id of snapshot to restore. If you do not want to restore a db, leave the default empty string."
  default     = ""
}

variable "subnet_ids" {
  description = "Subnet ids where Neptune should be provisioned. This value will override the values looked up by subnet_type"
  type        = list(string)
  default     = []
}

variable "subnet_type" {
  description = "Subnet ids where Neptune should be provisioned. This value will override the values looked up by subnet_type"
  type        = list(string)
  default     = ["private"]
}

variable "subnet_group_name" {
  description = "Name of subnet group where the Neptune instance will be provisioned."
  type        = string
  default     = null
}
 
variable "tags" {
  description = "Additional tags for all resources required for creating Neptune DB"
  type        = map(any)
  default     = {}
}

variable "terraform_assume_role" {
  description = "The assume role for the AWS Provider"
  type        = string
  default     = "super-role1" //"assumed-terraform"
}

variable "vpc_id" {
  description = "VPC where the Neptune should be provisioned"
  type        = string
  default     = ""
}
