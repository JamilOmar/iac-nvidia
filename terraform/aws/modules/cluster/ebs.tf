
resource "aws_iam_role" "aws_ebs_csi" {
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
          "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF
  name               = local.ebs_csi_name
}
resource "aws_iam_policy" "aws_ebs_csi" {
  policy = file("${path.module}/AWSEbsCsi.json")
  name   = local.ebs_csi_name
}
resource "aws_iam_role_policy_attachment" "aws_ebs_csi_attach" {
  role       = aws_iam_role.aws_ebs_csi.name
  policy_arn = aws_iam_policy.aws_ebs_csi.arn
}

resource "aws_eks_addon" "addons_ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.aws_ebs_csi.arn
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on               = [aws_eks_cluster.this]
}
resource "kubernetes_storage_class" "ebs-sc" {
  provider = kubernetes.main
  metadata {
    name = local.ebs_sc_name
    annotations = {
      "storageclass.kubernetes.io/is-default-class" : "true"
    }
  }
  parameters = {
    "csi.storage.k8s.io/fstype" = "ext4"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true
  depends_on             = [aws_eks_addon.addons_ebs_csi_driver]
}