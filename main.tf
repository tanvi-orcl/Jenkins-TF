# Basic Networking Configuration

data oci_identity_availability_domain rLid-SANJOSE-1-AD-1 {
  compartment_id = var.compartment_ocid
  ad_number      = "1"
}

resource oci_core_internet_gateway jenkinsInternetGW {
  compartment_id = var.compartment_ocid
  display_name = "jenkinsInternetGW"
  enabled      = "true"
  vcn_id = oci_core_vcn.jenkinsVCN.id
}

resource oci_core_subnet jenkinsSubnetA {
  cidr_block     = "10.1.0.0/24"
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.jenkinsVCN.default_dhcp_options_id
  display_name    = "jenkinsSubnetA"
  dns_label       = "jenkinsSubnetA"
  freeform_tags = {
  }
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.jenkinsVCN.default_route_table_id
  security_list_ids = [
    oci_core_vcn.jenkinsVCN.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.jenkinsVCN.id
}

resource oci_core_vcn jenkinsVCN {
  cidr_blocks = [
    "10.1.0.0/16",
  ]
  compartment_id = var.compartment_ocid
  display_name = "jenkinsVCN"
  dns_label    = "jenkinsVCN"
  freeform_tags = {
  }
}

resource oci_core_default_dhcp_options Default-DHCP-Options-for-jenkinsVCN {
  display_name = "Default DHCP Options for jenkinsVCN"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.jenkinsVCN.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "jenkinsVCN.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}

resource oci_core_default_route_table Default-Route-Table-for-jenkinsVCN {
  display_name = "Default Route Table for jenkinsVCN"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.jenkinsVCN.default_route_table_id
  route_rules {
    #description = <<Optional value not found in discovery>>
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.jenkinsInternetGW.id
  }
}

resource oci_core_default_security_list Default-Security-List-for-jenkinsVCN {
  display_name = "Default Security List for jenkinsVCN"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol  = "all"
    stateless = "false"
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  ingress_security_rules {
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.1.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  manage_default_resource_id = oci_core_vcn.jenkinsVCN.default_security_list_id
}