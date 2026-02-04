#
# `git` argument tab completion.
#

$ErrorActionPreference = 'Stop'

if(Get-Command git -ErrorAction SilentlyContinue) {
    # The hack for lazy loading the Posh-Git module
    Register-ArgumentCompleter -Native -CommandName git -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)

        Import-Module Posh-Git -ErrorAction SilentlyContinue

        # The PowerShell completion has a habit of stripping the trailing space when completing:
        # git checkout <tab>
        # The Expand-GitCommand expects this trailing space, so pad with a space if necessary.
        $padLength = $cursorPosition - $commandAst.Extent.StartOffset
        $textToComplete = $commandAst.ToString().PadRight($padLength, ' ').Substring(0, $padLength)
        Expand-GitCommand $textToComplete
    }
}
