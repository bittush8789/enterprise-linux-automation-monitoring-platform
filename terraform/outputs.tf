output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "app_node_public_ip" {
  description = "Public IP of the App/Monitoring Node"
  value       = aws_instance.app_node.public_ip
}

output "db_node_private_ip" {
  description = "Private IP of the Database Node"
  value       = aws_instance.db_node.private_ip
}

output "target_nodes_private_ips" {
  description = "Private IPs of the Target Nodes"
  value       = aws_instance.target_nodes[*].private_ip
}

output "backup_bucket_name" {
  description = "Name of the S3 Backup Bucket"
  value       = aws_s3_bucket.backups.id
}
