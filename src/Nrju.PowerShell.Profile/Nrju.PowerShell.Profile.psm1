$ErrorActionPreference = 'Stop'

<#
.SYNOPSIS
Tests availablility of the specified command.
#>
function Test-Command {
    [CmdletBinding()]
    param (
        # The command name.
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [SupportsWildcards()]
        [string[]]
        $Name
    )

    process {
        $Name | ForEach-Object {
            [bool](Get-Command $_ -ErrorAction SilentlyContinue)
        }
    }
}
