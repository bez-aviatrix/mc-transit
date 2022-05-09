terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      #version = "2.21.0"
    }
  }
}

provider "aviatrix" {
}

module "t" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.0.0"

  count = 3 

  name    = "t-${count.index + 1}-${var.name}"
  cloud   = var.cloud[count.index]
  region  = var.region[count.index]
  cidr    = cidrsubnet(var.cidr, 3, (count.index + 1))
  account = var.accounts[count.index]
  ha_gw   = var.ha
}

module "tp" {
  source  = "terraform-aviatrix-modules/mc-transit-peering/aviatrix"
  version = "1.0.6"

  transit_gateways = module.t.*.transit_gateway.gw_name
}

module "s" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.2"

  count = 3

  cloud      = var.cloud[count.index]
  name       = "s-${count.index + 1}-${var.name}-spoke"
  cidr       = cidrsubnet(var.cidr, 3, (count.index + 4))
  region     = var.region[count.index]
  account    = var.accounts[count.index]
  transit_gw = module.t[count.index].transit_gateway.gw_name
  ha_gw      = var.ha
}