$downloadToPath = "C:\tmp\jdk-8u192-windows-x64.exe"

# Make sure download path is available
If(!(test-path $downloadToPath))
{
      New-Item -ItemType Directory -Force -Path $downloadToPath
}

$remoteFileLocation = "https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-windows-x64.exe"

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    
$cookie = New-Object System.Net.Cookie 
  
$cookie.Name = "oraclelicense"
$cookie.Value = "accept-securebackup-cookie"
$cookie.Domain = ".oracle.com"

$session.Cookies.Add($cookie);

Invoke-WebRequest $remoteFileLocation -WebSession $session -TimeoutSec 900 -OutFile $downloadToPath

Start-Process -Wait -FilePath $downloadToPath -ArgumentList "/s INSTALL_SILENT=1 STATIC=0 AUTO_UPDATE=0 WEB_JAVA=1 WEB_JAVA_SECURITY_LEVEL=H WEB_ANALYTICS=0 EULA=0 REBOOT=0 NOSTARTMENU=0 SPONSORS=0 /L c:\tmp\jre-install.log"