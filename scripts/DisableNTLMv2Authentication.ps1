$registryPath = "HKLM:\System\CurrentControlSet\Control\Lsa"
$Name = "LMCompatibilityLevel"
$value = "2"

New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null