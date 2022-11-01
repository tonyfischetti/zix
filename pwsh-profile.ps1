
# Inspired by
# https://github.com/rkitover/windows-dev-guide/blob/master/profile.psm1


# TODO: store OS in string, instead
if (-not (test-path variable:global:iswindows)) {
    $global:IsWindows = $false
    $global:IsLinux   = $false
    $global:IsMacOS   = $false

    if (get-command get-cimsession -ea ignore) {
        $global:IsWindows = $true
    }
    elseif (test-path /System/Library/Extensions) {
        $global:IsMacOS   = $true
    }
    else {
        $global:IsLinux   = $true
    }
}

import-module packagemanagement,powershellget

if ($iswindows) {
    [Console]::OutputEncoding = [Console]::InputEncoding `
        = $OutputEncoding = new-object System.Text.UTF8Encoding

    set-executionpolicy -scope currentuser remotesigned
    set-culture en-US

}
elseif (-not $env:LANG) {
    $env:LANG = 'en_US.UTF-8'
}

$PSDefaultParameterValues["get-help:Full"] = $true
$env:PAGER = 'less'
$env:LESS = '-Q$-r$-X$-F$-K$--mouse'


if (-not $env:TERM) {
    $env:TERM = 'xterm-256color'
}
elseif ($env:TERM -match '^(xterm|screen|tmux)$') {
    $env:TERM = $matches[0] + '-256color'
}

if (-not $env:COLORTERM) {
    $env:COLORTERM = 'truecolor'
}

if (-not $env:DISPLAY) {
    $env:DISPLAY = '127.0.0.1:0.0'
}

if (-not $env:XAUTHORITY) {
    $env:XAUTHORITY = join-path $home .Xauthority

    if (-not (test-path $env:XAUTHORITY) `
        -and (
          ($xauth = (get-command -commandtype application xauth -ea ignore).source) `
          -or ($xauth = (gi '/program files/VcXsrv/xauth.exe' -ea ignore).fullname) `
        )) {

        $cookie = (1..4 | %{ "{0:x8}" -f (get-random) }) -join ''

        xauth add ':0' . $cookie | out-null
    }
}


Import-Module psreadline

Set-PSReadLineOption -Editmode vi
Set-PSReadLineOption -Bellstyle none

Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -function PreviousHistory
# TODO: get control j to work
Set-PSReadLineKeyHandler -Chord 'Ctrl+j' -function NextHistory


function Prompt {
    "`e[36m▇▇▇▇▇▇ " + (Get-Location) + " █ "
}

