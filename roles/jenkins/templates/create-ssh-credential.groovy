// IMPORTANT: This script contains jinja2 templating formatted variables
// It's intended use is deployment by Ansible using the template module
// Direct copying this file for use in jenkins will not work without adjustment.

import jenkins.*
import hudson.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;
import hudson.model.*
import jenkins.model.*
import hudson.security.*

// Create a SSH key based global credential, key file is stored on the master node
// location `/root/.ssh/id_rsa` 
String keyfile = "{{ jenkins_home }}/secrets/ssh_worker_id_rsa"

global_domain = Domain.global()

// Get the current credentials store
credentials_store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

// Generate a new Basic SSH User with Private Key authentication
credentials = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  "ssh-worker", // id
  "root", // username
  new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource(keyfile), // private key source
  "", // passphrase
  "Worker SSH Key" // description
)

// Add the credential to the store
credentials_store.addCredentials(global_domain, credentials)

// Export the current credential IDs
// This process might not be required.
def file1 = new File('{{ jenkins_home }}/credentials.txt')  
def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
      com.cloudbees.plugins.credentials.common.StandardUsernameCredentials.class,
      Jenkins.instance,
      null,
      null
  );
  for (c in creds) {
  //     println(c.id + ": " + c.description)
  // Writing to the files with the write method:
    file1 << "${c.username},${c.id},${c.description}"
  }