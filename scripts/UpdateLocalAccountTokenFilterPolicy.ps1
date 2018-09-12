$registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$Name = "LocalAccountTokenFilterPolicy"
$value = "1"

New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null