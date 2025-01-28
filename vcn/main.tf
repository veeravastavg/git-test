provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaovt7ogm3z32ftfy4fqrpyraofhn2y236bjn5g2ozo6idpiffue4a"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaqxmn2rfcyrudfhp74ltibsuzebtsbz6ee4smn4ffkab3xkyfgrpq"
  fingerprint      = "94:03:b0:c9:47:c9:93:6b:47:8d:cf:43:5c:8d:a8:7a"
  private_key_path = "~/.ssh/pvt.key"
  region           = "ap-hyderabad-1"
}

# Variables (Optional: Customize these values)
variable "vcn_name" {
  default = "My_VCN"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  default = "My_Subnet"
}

variable "subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created."
  default     = "ocid1.compartment.oc1..aaaaaaaame24tbb5alx262wky7hf4p4kt7tvoscyetbycfbxtwtmmmpdbdhq"
}

# VCN
resource "oci_core_vcn" "my_vcn" {
  cidr_block     = var.cidr_block
  compartment_id = var.compartment_id
  display_name   = var.vcn_name
}

# Subnet
resource "oci_core_subnet" "my_subnet" {
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.my_vcn.id
  cidr_block          = var.subnet_cidr
  display_name        = var.subnet_name
  prohibit_public_ip_on_vnic = false # Set to true to disable public IPs
}
