if status is-interactive
    # Commands to run in interactive sessions can go here
    source (starship init fish --print-full-init | psub)
    set Omen z131@192.168.0.101
    set Kso Administrator@10.13.149.128
end
