#
# Set `PSReadLine` options.
#

$ErrorActionPreference = 'Stop'

Set-PSReadLineOption -EditMode vi -ViModeIndicator Script `
    -ViModeChangeHandler {
        Write-Host -NoNewLine "`e[$(($args[0] -eq 'Command') ? 1 : 5) q"
    }
