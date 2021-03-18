terraform {
  backend "http" {
    address = "https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/JUoT17KsWyGUGUWO7OtW5gV5FhG6JOyx0yQVRuEagmfjNdyzxAAAMNMU9-SqnbRK/n/orasenatdoracledigital01/b/terraform-backend/o/terraform.tfstate"
    update_method = "PUT"
  }
}

provider oci {
	region 				 = var.primary_region
	tenancy_ocid         = var.tenancy_id   
  	user_ocid            = var.user_id
  	fingerprint          = var.api_fingerprint
  	private_key_path     = var.api_private_key_path
	# private_key_path     = var.api_key
	#private_key_path     = var.terraform_api_path
}

# provider oci { 
#   	alias                = "sanjose"
#   	region               = var.primary_region
#   	tenancy_ocid         = var.tenancy_id
# 	user_ocid            = var.user_id
#   	fingerprint          = var.api_fingerprint
#   	private_key_path     = var.api_private_key_path
# }