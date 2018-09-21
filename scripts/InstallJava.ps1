$downloadToPath = "C:\tmp\jdk-8u181-windows-x64.exe"
$remoteFileLocation = "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-windows-x64.exe"

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    
$cookie = New-Object System.Net.Cookie 
  
$cookie.Name = "oraclelicense"
$cookie.Value = "accept-securebackup-cookie"
$cookie.Domain = ".oracle.com"

$session.Cookies.Add($cookie);

Invoke-WebRequest $remoteFileLocation -WebSession $session -TimeoutSec 900 -OutFile $downloadToPath

Start-Process -Wait -FilePath $downloadToPath -ArgumentList '/s INSTALL_SILENT=1 STATIC=0 AUTO_UPDATE=0 WEB_JAVA=1 WEB_JAVA_SECURITY_LEVEL=H WEB_ANALYTICS=0 EULA=0 REBOOT=0 NOSTARTMENU=0 SPONSORS=0 /L c:\tmp\jre-install.log'