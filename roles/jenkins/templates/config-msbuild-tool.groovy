import hudson.model.*
import jenkins.model.*
import hudson.slaves.*
import hudson.plugins.*

def a = Jenkins.instance.getDescriptor("hudson.plugins.msbuild.MsBuildInstallation");
def existing = a.installations as List;
existing.add(new hudson.plugins.msbuild.MsBuildInstallation("Default", "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\MSBuild\\15.0\\bin\\MSBuild.exe",""));
a.setInstallations(existing as hudson.plugins.msbuild.MsBuildInstallation[])
a.save()