# Azure Virtual Machines

## (Object) Azure VNet

### Has
- Disks
  - OS
  - Data
  - Managed disks have persitence by replication
  - Integrated with availability sets/zones
  - Azure Backup support
  - RBAC access control
  - Encryption:
    - Server-side encryption: Encryption at rest (turned on by default)
    - Azure Disk Encryption: Encrypts the OS and data (bitlocker/dmcrypt).
      - Encryption keys are managed with Azure Keyvault
- NICs
  - Public IP
  - Private IP (Each NIC is connected to a VNET)
- Fault domains
  - VMS in the same fault domain share the same power/network swtich.
  - Any issues in one VM could affect all VMs in the same fault domain.
- Update domains
  - Controls when the underlying hardware is maintained and rebooted.
- Availability sets
  - Set manually. Distributes resources across fault/update domains.
- Scale sets
  - Handles Vm scaling, additional instances automatically
  - Can be configured with the same load balancer
  - Automatically put VMs of the same load balancer in different availability zones 

### Can do
- Ideal for lift&shift or legacy solutions (many legacy applications need special systems to run)
- Easy management and monitoring
- Easy scaling/availability
- Multiple OSs and versions

## Virutal machines walkthrough

### Via portal

1.  Create a new "Virtual Machine" resource from a Windows Server image.
1.  No Infrastructure redundancy required
1.  size: B1s
1.  credentials: username: "hello", password: "Password1A1A"
1.  OS disk: standard HDD
1.  no data disk
1.  Virtual network: VNET-Windows
1.  /17 subnet
1.  Boot diagnostics off (otherwise we need a storage account for the diag files)
1.  auto-shutdown: on (demo machine)

### Via powershell

1.  ```
    az vm create \
    --resource-group az303-cli \
    --name Linux-VM \
    --image UbuntuLTS \
    --public-ip-sku Standard \
    --public-ip-address linux-vm-pip \
    --admin-username azureuser \
    --admin-password password1A1A \
    --location norwayeast \
    --vnet-name VNET-linux \
    --size Standard_B1s
1.  `az vm open-port --resource-group az303-cli --name Linux-VM --port 22`
1.  ```
    az network nsg rule create --name SSH \
    --protocol Tcp \
    --nsg-name Linux-VMNSG \
    --priority 1000 \
    --direction Inbound \
    --resource-group az303-cli \
    --source-address-prefixes '*' \
    --source-port-range 0-65535 \
    --destination-address-prefixes '*' \
    --destination-port-range 0-65535 \
    --access Allow
1.  

1.27.16