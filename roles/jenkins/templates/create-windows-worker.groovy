import hudson.model.*
import jenkins.model.*
import hudson.slaves.*
import hudson.slaves.EnvironmentVariablesNodeProperty.Entry

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
List<Entry> env = new ArrayList<Entry>();
env.add(new Entry("key1","value1"))
env.add(new Entry("key2","value2"))
EnvironmentVariablesNodeProperty envPro = new EnvironmentVariablesNodeProperty(env);

agent.getNodeProperties().add(envPro)

// Create a "Permanent Agent"
Jenkins.instance.addNode(agent)

return "Node has been created successfully."