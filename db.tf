# Not yet finished
# Not yet finished
resource "aws_rds_cluster" "auroracluster" {
  cluster_identifier        = "auroracluster"
  availability_zones        = ["us-west-2a", "us-west-2b"]
  engine                    = "aurora-mysql"
  engine_version            = "5.7.mysql_aurora.2.11.1"
  
  database_name             = "auroradb"
  master_username           = "test"
  master_password           = "mustbeeightcharaters"
  skip_final_snapshot       = true
  final_snapshot_identifier = "aurora-final-snapshot"
  vpc_security_group_ids = [aws_security_group.dev_terraform_sg_allow_ssh_http.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  }
  resource "aws_db_subnet_group" "db_subnet" {
  name                   = "cp_db_subnet"
  subnet_ids             = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags                   = {
    Name                 = "DB subnet"
  }
}
# Be sure to use this when connecting to your DB from EC2
# sudo yum install mariadb
# use the writers instance endpoint
# mysql -h <endpoint> -P 3306 -u <mymasteruser> -p
resource "aws_rds_cluster_instance" "clusterinstance" {
  count              = 2
  identifier         = "clusterinstance-${count.index}"
  cluster_identifier = aws_rds_cluster.auroracluster.id
  instance_class     = "db.t3.small"
  engine             = "aurora-mysql"
  availability_zone  = "us-west-2${count.index == 0 ? "a" : "b"}"
  tags = {
    Name = "auroracluster-db-instance${count.index + 1}"
  }
}
