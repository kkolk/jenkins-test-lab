$downloadToPath = "C:\tmp\vs_buildtools.exe"
$remoteFileLocation = "https://aka.ms/vs/15/release/vs_buildtools.exe"

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    
Write-Host "Downloading vs_buildtools.exe"
Invoke-WebRequest $remoteFileLocation -WebSession $session -TimeoutSec 900 -OutFile $downloadToPath

Write-Host "Installing Build Tools"
# Install Build Tools excluding workloads and components with known issues.
# Start-Process -Wait -FilePath  $downloadToPath -ArgumentList '--quiet --norestart --nocache --installPath C:\BuildTools --all --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK'

# Write-Host "Adding Tools for Web Build Workload"

# Start-Process -Wait -FilePath  $downloadToPath -ArgumentList '--quiet --wait --norestart --cache --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.WebBuildTools --includeRecommended --includeOptional'

Write-Host "Fetching MSBuild.Microsoft.VisualStudio.Web.Targets"

$sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$targetNugetExe = "c:\tmp\nuget.exe"
Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
Set-Alias nuget $targetNugetExe -Scope Global -Verbose

nuget install MSBuild.Microsoft.VisualStudio.Web.Targets