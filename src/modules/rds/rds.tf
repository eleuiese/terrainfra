resource "aws_db_instance" "db_instance_django" {
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  name                   = "jobtestdb"
  username               = "root"
  password               = "jobtest1234"
  parameter_group_name   = "default.postgres13"
  skip_final_snapshot    = true
  identifier             = "dbdjango-1"
  db_subnet_group_name   = aws_db_subnet_group.subnet_rds.name
  vpc_security_group_ids = [aws_security_group.rds_sg1.id]
  publicly_accessible    = true
}

resource "aws_security_group" "rds_sg1" {
  name        = "rds_sg1"
  vpc_id      = data.aws_vpc.vpc_main.id
  description = "Allow 5432"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "subnet_rds" {
  name       = "subnet-group-rds"
  subnet_ids = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]

}

data "aws_subnet" "public_subnet1" {
  id = var.public_subnet1_id
}

data "aws_subnet" "public_subnet2" {
  id = var.public_subnet2_id
}

data "aws_vpc" "vpc_main" {
  id = var.vpc_id
}

