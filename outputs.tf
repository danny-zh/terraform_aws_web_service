
output "elb_public_dns_name" {
  description = "Public DNS names of the load balancer for this project"
  value       = module.elb_http.elb_dns_name
}