## please refer to the `blue` service in `kubernetes_resources.tf`
#resource "kubernetes_service" "green" {
#  metadata {
#    name      = "green-svc"
#    namespace = local.name
#    annotations = {
#      "service.beta.kubernetes.io/aws-load-balancer-type"            = "nlb"
#      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
#    }
#  }
#  spec {
#    selector = {
#      app = "green"
#    }
#
#    port {
#      port        = 80
#      target_port = 80
#    }
#
#    type = "LoadBalancer"
#  }
#
#  depends_on = [
#    module.project_eks
#  ]
#}
#
#
#
#
#
## please refer to `resource "aws_route53_record" "blue"` for blue in `dns.tf`
#resource "aws_route53_record" "green" {
#  zone_id = aws_route53_zone.private_dns.id
#  name    = "blue-green"
#  type    = "CNAME"
#  ttl     = "5"
#
#  weighted_routing_policy {
#    weight = 1
#  }
#
#  set_identifier = "green"
#  records        = [kubernetes_service.green.status.0.load_balancer.0.ingress.0.hostname] # https://github.com/hashicorp/terraform-provider-kubernetes/pull/1125
#}