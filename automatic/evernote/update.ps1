import-module au

$url = 'https://evernote.com/download/get.php?file=Win'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    Write-Host $url

    $temp_file = $env:TEMP + '\evernote.exe'
    Invoke-WebRequest $url -OutFile $temp_file
    Write-Host $temp_file

    $version = (Get-Command $temp_file).Version
    Write-Host $version

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update -NoCheckUrl -ChecksumFor 32