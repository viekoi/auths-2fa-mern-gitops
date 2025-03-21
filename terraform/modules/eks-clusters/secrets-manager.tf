resource "aws_iam_role" "secrets_store_csi_driver_dev" {
  name = "${module.eks.cluster_name}-secrets-manager-dev"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "pods.eks.amazonaws.com"
        },
        "Action": [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_store_csi_driver_dev" {
  name = "${module.eks.cluster_name}-secrets-manager-dev"
  
 policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = ["*"],
        Condition = {
          StringEquals = {
            "secretsmanager:ResourceTag/kubernetes-namespace" = "$${aws:PrincipalTag/kubernetes-namespace}",
            "secretsmanager:ResourceTag/eks-cluster-name"     = "$${aws:PrincipalTag/eks-cluster-name}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_store_csi_driver_dev" {
  policy_arn = aws_iam_policy.secrets_store_csi_driver_dev.arn
  role       = aws_iam_role.secrets_store_csi_driver_dev.name
}

resource "aws_eks_pod_identity_association" "secrets_store_csi_driver_dev" {
  cluster_name    = module.eks.cluster_name
  namespace       = "dev"
  service_account = "aws-secrets-manager"
  role_arn        = aws_iam_role.secrets_store_csi_driver_dev.arn
}



resource "aws_iam_role" "secrets_store_csi_driver_prod" {
  name = "${module.eks.cluster_name}-secrets-manager-prod"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "pods.eks.amazonaws.com"
        },
        "Action": [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_store_csi_driver_prod" {
  name = "${module.eks.cluster_name}-secrets-manager-prod"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "secretsmanager:ResourceTag/kubernetes-namespace" = "$${aws:PrincipalTag/kubernetes-namespace}"
            "secretsmanager:ResourceTag/eks-cluster-name"     = "$${aws:PrincipalTag/eks-cluster-name}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_store_csi_driver_prod" {
  policy_arn = aws_iam_policy.secrets_store_csi_driver_prod.arn
  role       = aws_iam_role.secrets_store_csi_driver_prod.name
}

resource "aws_eks_pod_identity_association" "secrets_store_csi_driver_prod" {
  cluster_name    = module.eks.cluster_name
  namespace       = "prod"
  service_account = "aws-secrets-manager"
  role_arn        = aws_iam_role.secrets_store_csi_driver_prod.arn
}


resource "helm_release" "secrets_store_csi_driver" {
  name = "secrets-store-csi-driver"

  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"
  version    = var.secrets_store_csi_driver_version

  set {
    name  = "syncSecret.enabled"
    value = true
  }


  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "secrets_store_csi_driver_provider_aws" {
  name = "secrets-store-csi-driver-provider-aws"

  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  namespace  = "kube-system"
  version    = var.secrets_store_csi-driver_provider_aws_version

  depends_on = [helm_release.secrets_store_csi_driver]
}