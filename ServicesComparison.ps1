# Get the list of running services
$RunningServices = Get-Service * | Where-Object {$_.Status -eq "Running"}

# Compare the list of running services to the baseline list
$ServiceComparison = Compare-Object (Import-Clixml Baseline-services.xml) $RunningServices -Property DisplayName | Where-Object {$_.SideIndicator -eq "<="}

# Output the list of running services
$RunningServices | Format-Table -AutoSize

# Save the list of running services and service comparison to an XML file
$Output = @{
    RunningServices = $RunningServices
    ServiceComparison = $ServiceComparison
}
$Output | Export-Clixml Output.xml

