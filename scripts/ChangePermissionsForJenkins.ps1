
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey("SOFTWARE\Classes\Wow6432Node\CLSID{72C24DD5-D70A-438B-8A42-98424B88AFB8}",[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::ChangePermissions)
$acl = $key.GetAccessControl()
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ("Administrators","FullControl","Allow")
$acl.SetAccessRule($rule)
$key.SetAccessControl($acl)

$key2 = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey("CLSID{76A64158-CB41-11D1-8B02-00600806D9B6}",[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::ChangePermissions)
$acl2 = $key2.GetAccessControl()
$acl2.SetAccessRule($rule)
$key2.SetAccessControl($acl2)

Restart-Service -Name remoteregistry