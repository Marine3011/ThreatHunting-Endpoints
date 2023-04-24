Get-Process | Where-Object {$_.Status -eq "Running"} | Format-Table -AutoSize
