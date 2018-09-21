import hudson.model.*
import jenkins.model.*
import hudson.slaves.*
import hudson.slaves.EnvironmentVariablesNodeProperty.Entry
import hudson.tools.*


/**
 * INSERT "Launch Method" SNIPPET HERE
 */
WORKER_NAME = "winworker"
WORKER_NODE_LABEL = "Windows"
WORKER_NODE_DESCRIPTION = "Windows worker node"
WORKER_HOSTNAME = "winworker.192.168.100.20.xip.io"
WORKER_HOME_FOLDER = "C:\\Jenkins"
WORKER_EXECUTORS =2

// Define a agent
Slave agent = new DumbSlave(
        WORKER_NAME,
        WORKER_HOME_FOLDER,
        new JNLPLauncher(),
        )


agent.nodeDescription = WORKER_NODE_DESCRIPTION
agent.numExecutors = WORKER_EXECUTORS
agent.labelString = WORKER_NODE_LABEL
agent.mode = Node.Mode.EXCLUSIVE
agent.retentionStrategy = new RetentionStrategy.Always()


// Example environmental variables, replace/remove as needed.
// List<Entry> env = new ArrayList<Entry>();
// env.add(new Entry("key1","value1"))
// env.add(new Entry("key2","value2"))
// EnvironmentVariablesNodeProperty envPro = new EnvironmentVariablesNodeProperty(env);
// agent.getNodeProperties().add(envPro)

// Setup Git Windows path
def gitToolDescriptor = Jenkins.getInstance().getDescriptor("hudson.plugins.git.GitTool")
def gitToolLocation = new ToolLocationNodeProperty.ToolLocation(gitToolDescriptor, "Default", "C:\\Program Files\\Git\\bin\\git.exe")

// Setup MSBuild Path
def msBuildDescriptor = Jenkins.getInstance().getDescriptor("hudson.plugins.msbuild.MsBuildInstallation");
def msBuildToolLocation = new ToolLocationNodeProperty.ToolLocation(msBuildDescriptor, "MSBuild", "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\MSBuild\\15.0\\bin\\MSBuild.exe")

// Create tool locations list
List<Entry> tools = new ArrayList<Entry>();
tools.add(gitToolLocation)
tools.add(msBuildToolLocation)
def toolLocationProperty = new ToolLocationNodeProperty(tools)

// Add list to agent
agent.getNodeProperties().add(toolLocationProperty)

// Create a "Permanent Agent"
Jenkins.instance.addNode(agent)

return "Node has been created successfully."