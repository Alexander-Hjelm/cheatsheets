# Hyper V

<!--ts-->
* [Hyper V](hyper-v.md#hyper-v)
   * [Create VM Script](hyper-v.md#create-vm-script)
   * [Transfer files to a linux VM](hyper-v.md#transfer-files-to-a-linux-vm)
   * [Troubleshooting](hyper-v.md#troubleshooting)
      * [Linux machine does not start](hyper-v.md#linux-machine-does-not-start)

<!-- Added by: runner, at: Wed Dec 29 11:29:09 UTC 2021 -->

<!--te-->

## Create VM Script

```powershell
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}


# Variables and settings and things... 
$VMLocation = "D:\VMs"
$VMNetwork = "BuildMachines"
$VMNetworkVLAN = 2484
$VMMemory = 1024MB
$VMMemoryMin = 768MB
$VMMemoryMax = 8GB
$VMOsDiskSize = 100GB
$VMDataDiskSize = 100GB
$VMCores = 4
# Om ni automagiskt vill ansluta en och samma iso varje gång får ni peka ut den här.
$VMISO = "D:\ISO\ubuntu-20.04.3-live-server-amd64.iso"
$VMName = "LinuxServer1"
#$VMName = Read-Host "Vad ska din VM heta?"

# Om det redan finns en VM eller en mapp som jag vill använda så gör jag inte det...
if (Get-VM -Name $VMName -ErrorAction SilentlyContinue) { 
    Write-Warning "Nänänä! Det finns redan en VM som heter så ju!"
    Write-Warning "Avbryter..."
    Pause
    Break
}
if (Test-Path "$VMLocation\$VMName") {
Write-Warning "Nänänä! Mappen $("$VMLocation\$VMName") finns ju redan!"
    Write-Warning "Avbryter..."
    Pause
    Break
}


try {
$ErrorActionPreference = "Stop"
Write-Host "Create new VM"
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetwork -Path $VMLocation -NoVHD
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-OS-Disk.vhdx" -SizeBytes $VMOsDiskSize
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-OS-Disk.vhdx"
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Data-Disk.vhdx" -SizeBytes $VMDataDiskSize
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Data-Disk.vhdx"
Set-VMProcessor -VMName $VMName -Count $VMCores
Set-VMDvdDrive -VMName $VMName -Path $VMISO
Start-VM -Name $VMName
Start-Sleep 5
Stop-VM -Name $VMName -TurnOff -Force


Write-Host "Get MacAddress and set it to static MAC address and assign VLAN"
$VMInfo = Get-VM $VMName
$CurrentMacAddress = $VMInfo.NetworkAdapters | Select –ExpandProperty MacAddress
Set-VMNetworkAdapter -VMName $VMName -StaticMacAddress $CurrentMacAddress
Set-VMNetworkAdapterVlan -VMName $VMName -Access -VlanId $VMNetworkVLAN

Write-Host "Set some default settings we like"
Set-VM -VMName $VMName -AutomaticCheckpointsEnabled $False -AutomaticStopAction ShutDown -AutomaticStartAction StartIfRunning

Write-Host "Set dynamic memory and stuff"
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $True -MinimumBytes $VMMemoryMin -StartupBytes $VMMemory -MaximumBytes $VMMemoryMax

Write-Host "Open the GUI so we can easaly mod whatever and mount ISO"
VMconnect localhost $VMName
}

catch {
    Write-Host "Ouuups! $($Error[0].Exception.Message)"
    pause
}
```

## Transfer files to a linux VM

Enable Guest Services in VM Settings -> Integration Services

## Troubleshooting

### Linux machine does not start

Disable Secure boot from the Security settings of the VM

