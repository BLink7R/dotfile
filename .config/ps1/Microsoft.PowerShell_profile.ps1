function conda {
    if (-not $script:CONDA_INITIALIZED) {
        $script:CONDA_INITIALIZED = $true
        (& conda.exe "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    }
    conda @args  
}

& "$home\Documents\WindowsPowerShell\SamplePSReadLineProfile.ps1"

Set-PSReadLineOption -Colors @{
    Command          = "DarkBlue"
    Comment          = "DarkGray"
    Default          = "Gray"
    Error            = "DarkRed"
    InlinePrediction = "$([char]0x1b)[3;90m" # 斜体深灰
    Keyword          = "DarkMagenta"
    String           = "$([char]0x1b)[3;32m" # 斜体深绿
    Variable         = "DarkCyan"
    Number           = "Blue"
}

Invoke-Expression (&starship init powershell)