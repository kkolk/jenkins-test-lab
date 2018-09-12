
# Jenkins worker parameters
$jenkinsJNLP = "http://jenkins.192.168.100.10.xip.io:8080/computer/winworker/slave-agent.jnlp"
$jenkinsAgentJAR = "http://jenkins.192.168.100.10.xip.io:8080/jnlpJars/agent.jar"
$jenkinsInstallPath = "C:\Jenkins"

# Windows Service Wrapper is used to run Jenkins as a Service.
$wswxURL = "http://repo.jenkins-ci.org/public/com/sun/winsw/winsw/2.1.0/winsw-2.1.0-bin.exe"

# Credentials for accessing Jenkins
# This should be re-worked for a production instance to use a more secure method of access.
$user = "jenkins"
$pass = "jenkins"

# Make sure download path is available
If(!(test-path $jenkinsInstallPath))
{
      New-Item -ItemType Directory -Force -Path $jenkinsInstallPath
}

# Convert username and password to base64 for authentication and setup our request headers
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

# Fetch the jnlp and read the secret
Invoke-WebRequest $jenkinsJNLP -Headers $headers -TimeoutSec 900 -OutFile "$jenkinsInstallPath\slave-agent.jnlp"
[xml]$jnlpXML = Get-Content "$jenkinsInstallPath\slave-agent.jnlp"
$jenkinsSecret = $jnlpXML.jnlp.'application-desc'.argument[0]

# Fetch the jenkins agent
Invoke-WebRequest $jenkinsAgentJAR -Headers $headers -TimeoutSec 900 -OutFile "$jenkinsInstallPath\agent.jar"

# Fetch the Windows Service Wrapper
Invoke-WebRequest $wswxURL -TimeoutSec 900 -OutFile "$jenkinsInstallPath\jenkins-slave.exe"

# Create the service XML file for the Jenkins Agent
$serviceFileContent = @"
<service>
  <id>JenkinsAgent</id>
  <name>Jenkins Agent</name>
  <description>This service runs an agent for Jenkins automation server.</description>
  <executable>java.exe</executable>
  <arguments>-Xrs -jar "%BASE%\agent.jar" -jnlpUrl $jenkinsJNLP -secret $jenkinsSecret</arguments>
  <logmode>rotate</logmode>
  <onfailure action="restart" />
  <extensions>
    <extension enabled="true" 
               className="winsw.Plugins.RunawayProcessKiller.RunawayProcessKillerExtension"
               id="killOnStartup">
      <pidfile>%BASE%\jenkins_agent.pid</pidfile>
      <stopTimeout>5000</stopTimeout>
      <stopParentFirst>false</stopParentFirst>
    </extension>
  </extensions>
</service>
"@

$serviceFileContent > "$jenkinsInstallPath\jenkins-slave.xml"

# Install required NET-Framework-Features
Install-WindowsFeature -Name NET-Framework-Features

# Uninstall the service if it exists in case we are reconfiguring it.
if (Get-Service "JenkinsAgent") {
  Get-Service "JenkinsAgent" | Stop-Service | Remove-Service
}

# Install the service
Start-Process -Wait -FilePath "$jenkinsInstallPath\jenkins-slave.exe" -ArgumentList "install"

# Start the service
Get-Service "JenkinsAgent" | Where-Object {$_.status -eq "Stopped"} | Restart-Service