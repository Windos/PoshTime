$maximumRuntimeSeconds = 3
$Path = 'C:\temp\'

$process = Start-Process -FilePath powershell.exe -ArgumentList "-windowstyle hidden -Command 'New-TsEntry -Path $Path'" -PassThru

try
{
    $process | Wait-Process -Timeout $maximumRuntimeSeconds -ErrorAction Stop
    Write-Warning -Message 'Process successfully completed within timeout.'
}
catch
{
    Write-Warning -Message 'Process exceeded timeout, will be killed now.'
    $process | Stop-Process -Force

    $Record = [pscustomobject] @{
		Time = Get-Date
        User = $env:USERNAME
		Activity = '** TimedOut **'
	}

    $Record | Export-Csv -Path "$Path\$($env:USERNAME).csv" -Append -NoTypeInformation -Force
}