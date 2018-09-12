$jenkinsJNLP = "http://jenkins.192.168.100.10.xip.io:8080/computer/winworker/slave-agent.jnlp"
$jenkinsAgentJAR = "http://jenkins.192.168.100.10.xip.io:8080/jnlpJars/agent.jar"
$downloadToPath = "C:\tmp\slave-agent.jnlp"
$user = "jenkins"
$pass = "jenkins"

# Convert username and password to base64 for authentication
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

$headers = @{ Authorization = $basicAuthValue }

Invoke-WebRequest $jenkinsJNLP -Headers $headers -TimeoutSec 900 -OutFile $downloadToPath
Invoke-WebRequest $jenkinsAgentJAR -Headers $headers -TimeoutSec 900 -OutFile "C:\tmp\agent.jar"

Invoke-Expression -Command "java -jar c:\tmp\agent.jar -jnlpCredentials $pair -jnlpUrl $jenkinsJNLP  -workDir ""C:\Jenkins\"""