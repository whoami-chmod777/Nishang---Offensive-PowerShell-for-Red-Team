
<#
.SYNOPSIS
Nishang script which encodes a string to base64 string.

.DESCRIPTION
This payload encodes the given string to base64 string and writes it to a file.

.PARAMETER Str
The string to be encoded

.EXAMPLE
PS > StringToBase64 "start-process calc.exe"

.LINK
http://labofapenetrationtester.blogspot.com/
https://github.com/samratashok/nishang
#>



function StringtoBase64
{
    [CmdletBinding()] 
        Param( [Parameter(Position = 0, Mandatory = $False)]
        [String]
        $Str,

        [Parameter(Position = 1, Mandatory = $False)]
        [String]
        $outputfile="$env:TEMP\encoded.txt", 

        [Switch]
        $IsString
    )

   if($IsString -eq $true)
    {
    
        $utfbytes  = [System.Text.Encoding]::Unicode.GetBytes($Str)
       
    }
  else
    {
        $utfbytes  = [System.Text.Encoding]::Unicode.GetBytes((Get-Content $Str))
    }

  $base64string = [System.Convert]::ToBase64String($utfbytes)
  Out-File -InputObject $base64string -FilePath "$outputfile"
}


