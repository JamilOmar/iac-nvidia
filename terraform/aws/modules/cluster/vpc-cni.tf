
data "aws_iam_policy_document" "aws_vpc_cni_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_vpc_cni" {
  assume_role_policy = data.aws_iam_policy_document.aws_vpc_cni_role_policy.json
  name               = local.vpc_ini_name
}
resource "aws_iam_policy" "aws_vpc_cni" {
  policy = file("${path.module}/AWSCni.json")
  name   = local.vpc_ini_name
}
resource "aws_iam_role_policy_attachment" "aws_vpc_ini_attach" {
  role       = aws_iam_role.aws_vpc_cni.name
  policy_arn = aws_iam_policy.aws_vpc_cni.arn
}

resource "aws_eks_addon" "addons_vpc_ini" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "vpc-cni"
  service_account_role_arn = aws_iam_role.aws_vpc_cni.arn
  resolve_conflicts        = "OVERWRITE"
  depends_on               = [aws_eks_cluster.this]
}

