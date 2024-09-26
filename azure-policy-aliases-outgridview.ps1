# List all namespaces available in Azure Policy
$AllNamespaces = (Get-AzPolicyAlias -ListAvailable).Namespace | Sort-Object | Get-Unique

# Select the namespaces you want to work with
$SelectedNamespaces = $null
$SelectedNamespaces = @()

$AllNamespaces | Out-GridView -Title "Select one or more namespace. Found: $($AllNamespaces.count)" -OutputMode Multiple `
| Foreach-object { $SelectedNamespaces += $_ }

# Get all aliases available in the selected namespaces
$AvailableAliases = $null
$AvailableAliases = @()

Foreach ($Namespace in $SelectedNamespaces)
{
   $AvailableAliases += (Get-AzPolicyAlias -NamespaceMatch $Namespace).Aliases | Select-Object Name, DefaultPath
}

# List all aliases available in the selected namespaces
$AvailableAliases | Out-GridView -Title "Available alias for selected ($($SelectedNamespaces.count)): $($SelectedNamespaces)" -OutputMode Single