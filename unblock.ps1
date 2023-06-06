## Assign default debug 
$global:debug = $false
If ($args.Count -gt 1 -and $args[1] -eq "debug"){
    $global:debug = $true
}

## Assign base directory 
$baseDir = $args[0]
'''
Function to write message on the console based on debug parameter or loglevel (1)
'''
Function clog {
    param( [String]$msg, [Int]$level)
    if ($global:debug  -or $level -eq 1){
        Write-Host  $msg
    }
}
clog "Unblocking all files in the folder $baseDir in recursive manner"  1
$c = 0

## Retrieve all files in the given path and invoke Unblock-File cmd for every file. 
Get-ChildItem -Path $baseDir -Recurse | % {
    $iPath = $_.FullName
    clog  "Unblocking the file $iPath" 0
    Unblock-File $iPath
    $c = $c + 1
}
clog "Script execution is completed successfully. Total Unblocked files: $c" 1

