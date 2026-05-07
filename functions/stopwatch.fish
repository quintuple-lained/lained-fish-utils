function stopwatch
    set start (date +%s.%N)
    while true
        printf "\r%.1f " (math (date +%s.%N) - $start)
        sleep 0.1
    end
end
