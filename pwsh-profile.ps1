
Import-Module PSReadLine

Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -function PreviousHistory
# TODO: get control j to work
Set-PSReadLineKeyHandler -Chord 'Ctrl+j' -function NextHistory

$PSReadLineOptions = @{
    EditMode = "Vi"
    Bellstyle = "none"
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        "Command" = "#8181f7"
    }
}
Set-PSReadLineOption @PSReadLineOptions

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete



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

# if (-not $env:XAUTHORITY) {
#     $env:XAUTHORITY = join-path $home .Xauthority
#
#     if (-not (test-path $env:XAUTHORITY) `
#         -and (
#           ($xauth = (get-command -commandtype application xauth -ea ignore).source) `
#           -or ($xauth = (gi '/program files/VcXsrv/xauth.exe' -ea ignore).fullname) `
#         )) {
#
#         $cookie = (1..4 | %{ "{0:x8}" -f (get-random) }) -join ''
#
#         xauth add ':0' . $cookie | out-null
#     }
# }



$PSDefaultParameterValues["get-help:Full"] = $true


function Prompt {
    "`e[36m▇▇▇▇▇▇ " + (Get-Location) + " █ "
}

