provider "kubernetes" {
  host                   = try(module.eks.cluster_endpoint, "")
  cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "")
  
  # Ignore errors during destroy
  ignore_annotations = [
    "kubectl.kubernetes.io/last-applied-configuration"
  ]
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.clusterName
}

##