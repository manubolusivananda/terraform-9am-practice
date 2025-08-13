# crate of rds instance
resource "aws_db_instance" "rds" {
    identifier = var.identifier
    engine = var.engine
    engine_version = var.engine_version
    instance_class = var.instance_class
    allocated_storage = var.allocated_storage
    username = var.username
    password = var.password
    publicly_accessible = var.publicly_accessible
    skip_final_snapshot = var.skip_final_snapshot 
    deletion_protection = var.delete_protection
    multi_az = var.mutli_azs
    backup_retention_period = var.backup_retention_period
  
}

