resource "aws_efs_file_system" "aws_efs" {
  creation_token   = "cluster-${var.environment}"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true
  depends_on       = [aws_eks_cluster.this]
}

resource "aws_efs_mount_target" "aws_efs_zone" {
  count           = length(var.private_subnets_cidr)
  file_system_id  = aws_efs_file_system.aws_efs.id
  subnet_id       = element(aws_subnet.private_subnet.*.id, count.index)
  security_groups = [aws_eks_cluster.this.vpc_config[0].cluster_security_group_id]
  depends_on      = [aws_efs_file_system.aws_efs]
}






resource "aws_iam_role" "aws_efs_csi" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.eks.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub": "system:serviceaccount:kube-system:efs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  name               =local.efs_csi_name
}
resource "aws_iam_policy" "aws_efs_csi" {
  policy = file("${path.module}/AWSEfsCsi.json")
  name   = local.efs_csi_name
}
resource "aws_iam_role_policy_attachment" "aws_efs_csi_attach" {
  role       = aws_iam_role.aws_efs_csi.name
  policy_arn = aws_iam_policy.aws_efs_csi.arn
}

resource "kubernetes_service_account" "aws_efs_csi" {
  provider = kubernetes.main
  metadata {
    name      = "efs-csi-controller-sa"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" : "aws-efs-csi-driver"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" : aws_iam_role.aws_efs_csi.arn
    }

  }
  depends_on = [aws_iam_role_policy_attachment.aws_efs_csi_attach]
}


resource "helm_release" "aws-efs-csi-driver" {
  name       = local.efs_csi_driver_name
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/eks/aws-efs-csi-driver"
  }

  set {
    name  = "controller.serviceAccount.create"
    value = false
  }
  set {
    name  = "controller.serviceAccount.name"
    value = "efs-csi-controller-sa"
  }

  depends_on = [
    kubernetes_service_account.aws_efs_csi
  ]
}

resource "kubernetes_storage_class" "efs-sc" {
  provider = kubernetes.main
  metadata {
    name = "efs-sc"
  }
  parameters = {
    "fileSystemId"     = aws_efs_file_system.aws_efs.id
    "provisioningMode" = "efs-ap"
    "directoryPerms"   = "755"
    "uid"              = "1001"
    "gid"              = "1001"
  }
  storage_provisioner = "efs.csi.aws.com"
  depends_on          = [helm_release.aws-efs-csi-driver]
}


