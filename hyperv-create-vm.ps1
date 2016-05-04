#
# Asumptions:
# We asume the VHD folder exists
# We asume the virtual switch is present and configured
#

$CLI1 = "Development-Ubuntu-15.10"		# VM Name
$CRAM = 4GB				                # VM RAM
$CLI1VHD = 80GB				            # VM Hardisk
$VMLOC = "C:\ProgramData\Microsoft\Windows\Hyper-V\New Virtual Machine\Virtual Hard Disks\"			        # Location
$NetworkSwitch1 = "KeithVS"	# Name of the Network Switch
$W12R2ISO = "C:\Users\keith\Downloads\ubuntu-15.10-desktop-amd64.iso" #ISO to use to do deployment


# Create VM Folder and Network Switch
MD $VMLOC -ErrorAction SilentlyContinue

$TestSwitch = Get-VMSwitch -Name $NetworkSwitch1 -ErrorAction SilentlyContinue; if ($TestSwitch.Count -EQ 0){New-VMSwitch -Name $NetworkSwitch1 -SwitchType Private}

# Create Virtual Machines
New-VM -Name $CLI1 -Path $VMLOC -MemoryStartupBytes $CRAM -NewVHDPath $VMLOC\$CLI1.vhdx -NewVHDSizeBytes $CLI1VHD -SwitchName $NetworkSwitch1


# Configure Virtual Machines
Set-VMDvdDrive -VMName $CLI1 -Path $W12R2ISO
Start-VM $CLI1

