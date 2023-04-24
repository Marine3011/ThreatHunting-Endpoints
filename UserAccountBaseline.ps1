# Get the list of local users on the computer
$LocalUsers = Get-LocalUser

# Save the list of local users to an XML file
$LocalUsers | Export-Clixml LocalUsers.xml

# Import the baseline list of local users from the XML file
$BaselineUsers = Import-Clixml Baseline-users.xml

# Compare the list of local users to the baseline list
$UserComparison = Compare-Object $BaselineUsers $LocalUsers -Property Name | Where-Object {$_.SideIndicator -eq "<="}

# If new users were found, display a message
if ($UserComparison) {
    Write-Host "The following new local users have been detected:"
    $UserComparison | Select-Object -ExpandProperty InputObject | Select-Object -ExpandProperty Name | ForEach-Object {Write-Host "- $_"}
}
else {
    Write-Host "No new local users detected."
}
