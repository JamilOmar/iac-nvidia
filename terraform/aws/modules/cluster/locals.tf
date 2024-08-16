locals {

    eks_name         = var.eks_name_override != null ? var.eks_name_override : "${var.project}-eks-${var.environment}"
    alb_controller_name = var.alb_controller_name_override != null ? var.alb_controller_name_override : "${var.project}-load-balancer-controller-${var.environment}"
    vpc_ini_name         = var.vpc_ini_name_override != null ? var.vpc_ini_name_override : "${var.project}-vpc-cni-${var.environment}"
    efs_csi_name   = var.efs_csi_name_override != null ? var.efs_csi_name_override : "${var.project}-efs-csi-${var.environment}"
    efs_csi_driver_name = var.efs_csi_driver_name_override != null ? var.efs_csi_driver_name_override : "${var.project}-efs-csi-driver-${var.environment}"
    ebs_csi_name   = var.ebs_csi_name_override != null ? var.ebs_csi_name_override : "${var.project}-ebs-csi-${var.environment}"
    ebs_sc_name  = var.ebs_sc_name_override != null ? var.ebs_sc_name_override : "${var.project}-ebs-sc-${var.environment}"
    eks_security_group_name  = var.eks_security_group_name_override != null ? var.eks_security_group_name_override :"${var.project}-eks-sg-${var.environment}"
    internet_gateway_name   = var.internet_gateway_name_override != null ? var.internet_gateway_name_override : "${var.project}-ig-${var.environment}"
    nat_name  = var.nat_name_override != null ? var.nat_name_override : "${var.project}-nat-${var.environment}"
    nat_eip_name  = var.nat_eip_name_override != null ? var.nat_eip_name_override : "${var.project}-nat-eip-${var.environment}"
    private_nodes_group_name = var.private_nodes_group_name_override != null ? var.private_nodes_group_name_override : "${var.project}-private-nodes-${var.environment}"
    private_nodes_iam_role_name = var.private_nodes_iam_role_name_override != null ? var.private_nodes_iam_role_name_override : "${var.project}-nodes-iam-role-${var.environment}"
    private_route_table_name = var.private_route_table_name_override != null ? var.private_route_table_name_override : "${var.project}-private-route-table-${var.environment}"
    public_route_table_name = var.public_route_table_name_override != null ? var.public_route_table_name_override : "${var.project}-public-route-table-${var.environment}"
    public_subnet_name = var.public_subnet_name_override != null ? var.public_subnet_name_override : "public-eks-subnet"
    private_subnet_name = var.private_subnet_name_override != null ? var.private_subnet_name_override : "private-eks-subnet"
    eks_iam_role_name = var.eks_iam_role_name_override != null ? var.eks_iam_role_name_override : "${var.project}-eks-iam-role-${var.environment}"
    http_port    = 80
    any_port     = 0
    any_protocol = "-1"
    tcp_protocol = "tcp"
    all_ips      = ["0.0.0.0/0"]
    all_ipsv6      = ["::/0"]
  }