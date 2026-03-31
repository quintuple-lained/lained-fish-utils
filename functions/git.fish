function git
    if test (count $argv) -ge 1; and test "$argv[1]" = push
        __git_push_guard $argv[2..]; or return 1
        command git $argv
    else
        command git $argv
    end
end
