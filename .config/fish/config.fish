if status is-interactive
    # Commands to run in interactive sessions can go here
    source (/data/data/com.termux/files/usr/bin/starship init fish --print-full-init | psub)
end