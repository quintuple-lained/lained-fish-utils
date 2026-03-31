function gps
    __git_push_guard $argv; or return 1
    command git push $argv
end
