function gln --description "Get lines from a file: gln <file> <start_line> <end_line>"
    if test (count $argv) -ne 3
        echo "Usage: gln <file> <start_line> <end_line>"
        return 1
    end
    
    set file $argv[1]
    set start $argv[2]
    set end $argv[3]
    
    if not test -f $file
        echo "Error: File '$file' not found"
        return 1
    end
    
    set next (math $end + 1)
    sed -n "$start,$end p; $next q" $file
end
