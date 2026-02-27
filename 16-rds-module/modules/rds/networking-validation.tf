##############################
# Subnet Validation
##############################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id != data.aws_vpc.default.id
      error_message = <<-EOT
        The following subnet is part of the default VPC:

        Name = ${self.tags.Name}
        ID   = ${self.id}

        Please do not deploy RDS instances in the default VPC.
        EOT
    }

    // Optional additional validation to ensure subnets are tagged as private

    postcondition {
      condition = can( lower(self.tags.access) == "private")

      error_message = <<EOT
        The following subnet is not marked as private.

         Name: ${self.tags.Name}
         ID: ${self.id}

        Please ensure that the subnet is properly tagged by adding:

        access = private
EOT
    }

  }
}



##############################
# Security Group Validation
##############################

// Fetch all rules for the provided security groups

data "aws_vpc_security_group_rules" "input" {
  filter {
    name   = "group-id"
    values = var.security_group_ids
  }
}


data "aws_vpc_security_group_rule" "example" {
  for_each = toset(data.aws_vpc_security_group_rules.input.ids)
  security_group_rule_id = each.value


  lifecycle {
  postcondition {
    condition = (
      self.is_egress ||
      (
        self.cidr_ipv4 == null &&
        self.cidr_ipv6 == null &&
        self.referenced_security_group_id != null
      )
    )

    error_message = <<EOT
The following security group contains an invalid inbound rule: ${self.security_group_id}

Please ensure the following conditions are met:
Rules must not allow inbound traffic from IP CIDR blocks, only from other security groups.
EOT
  }
}

}