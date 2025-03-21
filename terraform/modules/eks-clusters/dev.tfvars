region = "us-east-1"
app_name = "auths-2fa-mern"
vpc_cidr_block = "10.0.0.0/16"
azs =  ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
public_subnets = ["10.0.64.0/19", "10.0.96.0/19"]
kubernetes_version = 1.32
cert_manager_version = "v1.14.5"
cluster_autoscaler_version = "9.37.0"
aws_load_balancer_controller_version = "1.7.2"
ingress_nginx_version = "4.10.1"
secrets_store_csi_driver_version = "1.4.8"
secrets_store_csi-driver_provider_aws_version = "0.3.11"
argocd_version = "7.8.11"
argocd_image_updater_version = "0.12.0"