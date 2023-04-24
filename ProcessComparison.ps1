# Get the list of running processes
$RunningProcesses = Get-Process | Where-Object {$_.Status -eq "Running"}

# Output the list of running processes
$RunningProcesses | Format-Table -AutoSize

# Compare the list of running processes to the baseline list
$ProcessComparison = Compare-Object (Import-Clixml Baseline-processes.xml) $RunningProcesses -Property ProcessName | Where-Object {$_.SideIndicator -eq "<="}

# Save the list of running processes and process comparison to an XML file
$Output = @{
    RunningProcesses = $RunningProcesses
    ProcessComparison = $ProcessComparison
}
$Output | Export-Clixml Output.xml
