module "s3" {
  source      = "./S3"
  bucket_name = var.bucket
}





module "iam" {
  source     = "./IAM"
  role       = var.role_name
  depends_on = [module.s3]

}


module "vpc" {
  source = "./Vpc"
  cidr = var.cidr
  vpc_name = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_name = var.public_subnet_name
}

module "ec2" {
  source = "./Ec2"
  subnetid = module.vpc.public_subnet_id
  ami = "ami-07ef4004db979fcd4"
  instance_type = "t2.micro"

  
}