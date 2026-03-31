function __git_push_guard
    # Colours (256-colour)
    set -l red (set_color -o brred)
    set -l yellow (set_color -o bryellow)
    set -l cyan (set_color -o brcyan)
    set -l magenta (set_color -o brmagenta)
    set -l green (set_color -o brgreen)
    set -l dim (set_color 245)
    set -l reset (set_color normal)
    set -l bold (set_color -o white)

    # Gather identity
    set -l user_name (git config user.name 2>/dev/null; or echo "unknown")
    set -l user_email (git config user.email 2>/dev/null; or echo "unknown")

    # Gather repo info
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null; or echo "unknown")
    set -l repo_name (basename "$repo_root")
    set -l remote_url (git remote get-url origin 2>/dev/null; or echo "no remote")

    # Gather branch
    set -l branch (git symbolic-ref --short HEAD 2>/dev/null; or echo "detached")

    # Detect force push
    set -l is_force false
    for arg in $argv
        switch $arg
            case -f --force --force-with-lease --force-if-includes
                set is_force true
        end
    end

    # Display guard
    echo ""
    echo "$dim─────────────────────────────────────────$reset"
    echo "$bold  GIT PUSH SAFETY GATE$reset"
    echo "$dim─────────────────────────────────────────$reset"
    echo ""
    echo "  $dim Identity:$reset  $cyan$user_name$reset <$cyan$user_email$reset>"
    echo "  $dim   Branch:$reset  $green$branch$reset"
    echo "  $dim     Repo:$reset  $magenta$repo_name$reset"
    echo "  $dim   Remote:$reset  $remote_url"

    if test "$is_force" = true
        echo ""
        echo "  $red *** FORCE PUSH DETECTED ***$reset"
        echo "  $yellow This will rewrite remote history!$reset"
    end

    echo ""
    echo "$dim─────────────────────────────────────────$reset"
    echo ""

    # Prompt — default NO
    read -l -P "$yellow  Proceed with push? [y/N]:$reset " confirm

    switch (string lower -- "$confirm")
        case y yes
            return 0
        case '*'
            echo ""
            echo "  $red Push aborted.$reset"
            echo ""
            return 1
    end
end
