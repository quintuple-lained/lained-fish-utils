function tcb --description 'Type password from clipboard using dotool with configurable delay'
    # Prevent this command from being saved to history
    history delete --exact --case-sensitive -- (history | head -n 1)
    
    # Call the bash script with arguments
    ~/scripts/scriptlang/paste-type.sh  $argv
end
