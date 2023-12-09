# resource "aws_efs_file_system" "kube" {
#   creation_token = "${local.prefix}-eks-efs"
# }

# resource "aws_efs_mount_target" "mount" {
#   file_system_id  = aws_efs_file_system.kube.id
#   subnet_id       = each.key
#   for_each        = toset(module.vpc.private_subnets)
#   security_groups = [aws_security_group.efs.id]
# }

# resource "aws_security_group" "efs" {
#   name        = "${local.prefix} efs"
#   description = "Allow traffic"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     description = "nfs"
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "TCP"
#     cidr_blocks = [module.vpc.vpc_cidr_block]
#   }
# }

# output "efs_id" {
#   value = aws_efs_file_system.kube.id
# }
