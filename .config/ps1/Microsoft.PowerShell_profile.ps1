function conda {
    if (-not $script:CONDA_INITIALIZED) {
        $script:CONDA_INITIALIZED = $true
        (& conda.exe "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    }
    conda @args  
}

& "$home\Documents\WindowsPowerShell\SamplePSReadLineProfile.ps1"

Invoke-Expression (&starship init powershell)