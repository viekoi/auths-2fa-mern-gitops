resource "helm_release" "ingress_nginx" {
  name = "ingress-nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = var.ingress_nginx_version

   values = [file("${path.module}/values/ingress-nginx.yaml")]


   depends_on = [
    helm_release.aws_load_balancer_controller_version
  ]
}