# Azure Networking

## (Object) Azure VNet

### Has
- Subnets
  - Resources (VMs etc)
  - Address blocks (Logical divisions)
  - Reserved IPs per block:
    - x.x.x.0: Network address
    - x.x.x.1: Default gateway
    - x.x.x.2, x.x.x.3: Azure DNS
    - x.x.x.5: Network broadcast
  - min size: /39 (5 ips)
  - max size /8
- Dedicated address block (should not overlap with other VNets)
- Services
  - Service requirements
    - Each service deployed in an azure VNet comes with different requirements on routing, types of traffic
    - E.g. Some services may require their own subnets, so there must be unallocated space.
- Virtual appliances:
  - E.g. gateways, routers, firewalls, ADCs.
    - Each spawned from their own image
  - By default Azure routes traffic between all subnets in a VPN
    - Can be overridden to prvenet routing between certain subnets, or force route traffic through certain network appliances.
- Service endpoint:
  - Limit access to services to certain subnets through configuring service endpoints.
- Network Security Groups:
  - Each subnet is associated with 1 or 0 NSGs.
  - Contains rules that allow/deny traffic between traffic and destinations.

VNETs can be linked together.

### Can do
- Set up VPNs (site-site or point-site).
- Integrate on-prem and cloud resources (hybrid solutions).

## Networking walkthrough

### Via portal

1. Create a "Virtual Network" resource.
1. Create subnets with address spaces

### Via powershell

1. `az group create --name az303-cli --tags="course=az303" --location=norwayeast`
1. `az network vnet create --name VNET-linux --resource-group az303-cli --location norwayeast --address-prefix 10.0.0.0/16`
1. `az network vnet subnet create --address-prefixes 10.0.0.0/17 --name SNET-Linux-1 --resource-group az303-cli --vnet-name VNET-linux`