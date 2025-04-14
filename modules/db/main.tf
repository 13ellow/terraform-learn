resource "aws_db_subnet_group" "db-subnet-group" {
    name = "terraform-learn"
    subnet_ids = var.subnet_ids

    tags = {
      Name = "terraform-learn-db-subnet-group"
    }
}

resource "aws_db_instance" "db-instance"{
    # required attributes
    instance_class = "db.t3.micro"
    allocated_storage = 5
    engine = "mysql"
    engine_version = "8.4.4"

    username = var.username
    password = var.password

    # others
    availability_zone = var.availability_zone
    # multi_az = true
    db_name = var.db_name
    db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
    identifier = "db-terraform"

    skip_final_snapshot = true
    vpc_security_group_ids = var.security_groups
}