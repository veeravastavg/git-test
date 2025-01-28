provider "oci" {
  tenancy_ocid     = "ocid1.user.oc1..aaaaaaaaqxmn2rfcyrudfhp74ltibsuzebtsbz6ee4smn4ffkab3xkyfgrpq"
  user_ocid        = ""
  fingerprint      = ""
  private_key_path = ""
  region           = ""
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
  default = "10.0.1.0/24"
}

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created."
  default     = "<your_compartment_ocid>"
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
