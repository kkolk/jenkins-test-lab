# quick script to resize windows partition to maximum after virtual disk resizing.

$size = (Get-PartitionSupportedSize -DiskNumber 0 -PartitionNumber 2)
Get-Partition -DiskNumber 0 -PartitionNumber 2 | Resize-Partition -Size $size.SizeMax

$result = [math]::round(($size.SizeMax / (1024*1024*1024)),2)

Write-Host "Partition is now $result GB."