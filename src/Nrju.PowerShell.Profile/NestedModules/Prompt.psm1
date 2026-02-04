#
# Customize the PowerShell prompt string.
#

$ErrorActionPreference = 'Stop'

# Colors
$W = "`e[37m";
$G = "`e[32m";
$B = "`e[34m";
$R = "`e[31m";

# Cursor
$C = "`e[5 q"

# User and host
$U = [System.Environment]::UserName
$M = [System.Environment]::MachineName

# Is the user an admin?

$A = $false

switch ($PSVersionTable.Platform) {
    'Win32NT' {
        $Identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $Principal = New-Object Security.Principal.WindowsPrincipal $Identity
        $A = $Principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    }
    'Linux' {
        $A = ((id -u) -eq 0)
    }
}

function Prompt {
    $h = [regex]::Escape($HOME)
    $s = [regex]::Escape([System.IO.Path]::DirectorySeparatorChar)
    $d = (Get-Location).Path -replace "^$h(?<tail>$s.*)?",'~${tail}'

    $Host.UI.RawUI.WindowTitle = $d

    $A ? "$($W)PS $($R)$($U)@$($M):$($R)$($D)$($W)`#$($C) "
       : "$($W)PS $($G)$($U)@$($M)$($W):$($B)$($D)$($W)`$$($C) "
}
