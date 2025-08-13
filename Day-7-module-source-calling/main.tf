module "nada" {
    source = "../DAY-7-source"
    identifier = "database-3"
    engine = "mysql"
    engine_version = "8.0.42"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    username = "admin"
    password = "siva123456"
    publicly_accessible = false
    skip_final_snapshot = true
    delete_protection = false
    mutli_azs = false 
    backup_retention_period = 7
  
}