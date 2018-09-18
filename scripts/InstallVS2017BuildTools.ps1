$downloadToPath = "C:\tmp\vs_buildtools.exe"
$remoteFileLocation = "https://aka.ms/vs/15/release/vs_buildtools.exe"

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    
Write-Host "Downloading vs_buildtools.exe"
Invoke-WebRequest $remoteFileLocation -WebSession $session -TimeoutSec 900 -OutFile $downloadToPath

Write-Host "Installing Build Tools"
# Install Build Tools excluding workloads and components with known issues.
# Start-Process -Wait -FilePath  $downloadToPath -ArgumentList '--quiet --norestart --nocache --installPath C:\BuildTools --all --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK'

Start-Process -Wait -FilePath  $downloadToPath -ArgumentList '--quiet --wait --norestart --nocache --installPath C:\BuildTools --all'