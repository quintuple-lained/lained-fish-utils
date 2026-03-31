function timer
    set -l input $argv[1]
    set -l message (test (count $argv) -gt 1; and echo $argv[2..-1]; or echo "Time's up!")

    # Parse input (5m or 300)
    set -l total_seconds
    if string match -qr '^\d+m$' "$input"
        set total_seconds (math (string replace 'm' '' -- "$input") "*" 60)
    else if string match -qr '^\d+$' "$input"
        set total_seconds $input
    else
        echo "Usage: timer [seconds/minutes]"
        return 1
    end

    set -l remaining $total_seconds

    while test $remaining -gt 0
        set -l mins (math -s0 "$remaining / 60")
        set -l secs (math "$remaining % 60")

        # Simple blinker: toggle between '*' and ' '
        set -l blink (test (math "$remaining % 2") -eq 0; and echo "*"; or echo " ")

        printf "\r%s %02d:%02d" $blink $mins $secs

        sleep 1
        set remaining (math $remaining - 1)
    end

    printf "\r\033[K" 
    notify-send "Timer Expired" "$message"
end
