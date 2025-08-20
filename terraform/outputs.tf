# Quick visibility in CLI and CI logs
output "instance_ids" {
  value       = { for k, v in aws_instance.vm : k => v.id }
  description = "EC2 instance IDs by framework"
}