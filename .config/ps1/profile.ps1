function conda {
    if (-not $script:CONDA_INITIALIZED) {
        $script:CONDA_INITIALIZED = $true
        (& conda.exe "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    }
    conda @args  
}

function vi {
    if ($env:NVIM_HOST) {
        nvim --server $env:NVIM_HOST --remote $args
    } else {
        nvim $args
    }
}

function ohosdev {
    $env:OHOS_NDK_HOME = "D:/ohos_sdk_windows/default/openharmony"
    $env:PATH = "$env:OHOS_NDK_HOME/native/build-tools/cmake/bin;$env:OHOS_NDK_HOME/toolchains;$env:PATH"
    # $env:PATH = "$env:OHOS_NDK_HOME\toolchains;$env:PATH"
    # hdc fport tcp:10603 tcp:2020
    # hdc fport tcp:10605 tcp:2021
    # hdc fport tcp:10608 tcp:2022
    # hdc fport tcp:10611 tcp:2023
    # hdc fport tcp:10615 tcp:2024
    # hdc fport ls
}

& "$home/.config/ps1/SamplePSReadLineProfile.ps1"

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

