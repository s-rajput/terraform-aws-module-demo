output "neptune_cluster_identifier" {
  value = "${aws_neptune_cluster.example.id}"
}

output "neptune_cluster_instances" {
  value = "${aws_neptune_cluster.example.cluster_members}"
}

# output "neptune_cluster_reader_endpoint" { 
#    value = ["${aws_neptune_cluster_endpoint.reader.*.cluster_endpoint_identifier}"]  
# }

# output "neptune_cluster_writer_endpoint" {
#   value = ["${aws_neptune_cluster_endpoint.writer.*.cluster_endpoint_identifier}"] 
# }

output "neptune_cluster_endpoint" {
  value = "${aws_neptune_cluster.example.endpoint}"
}

output "neptune_cluster_instance_endpoints" {
  value = ["${aws_neptune_cluster_instance.example.*.identifier}"] 
}


# output "SSH Port Forward Command" {
#   value = "ssh -L8182:${aws_neptune_cluster.example.endpoint}:8182 ec2-user@${aws_instance.neptune-ec2-connector.public_ip}"
# }