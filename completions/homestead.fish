# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

# homestead autocompletion

function __fish_homestead_no_command -d 'Test if homestead has yet to be given the main command'
    set -l cmd (commandline -opc)
    test (count $cmd) -eq 1
end

function __fish_homestead_using_command
    set -l cmd (commandline -opc)
    set -q cmd[2]
    and test "$argv[1]" = $cmd[2]
end

function __fish_homestead_using_command_and_no_subcommand
    set -l cmd (commandline -opc)
    test (count $cmd) -eq 2
    and test "$argv[1]" = "$cmd[2]"
end

function __fish_homestead_using_subcommand --argument-names cmd_main cmd_sub
    set -l cmd (commandline -opc)
    set -q cmd[3]
    and test "$cmd_main" = $cmd[2] -a "$cmd_sub" = $cmd[3]
end

function __fish_homestead_boxes -d 'Lists all available homestead boxes'
    command homestead box list | while read -l name _
        echo $name
    end
end

# --version and --help are always active
complete -c homestead -f -s v -l version -d 'Print the version and exit'
complete -c homestead -f -s h -l help -d 'Print the help and exit'

# box
complete -c homestead -f -n '__fish_homestead_no_command' -a 'box' -d 'Manages boxes'
complete -c homestead -n '__fish_homestead_using_command_and_no_subcommand box' -a add -d 'Adds a box'
complete -c homestead -f -n '__fish_homestead_using_command_and_no_subcommand box' -a list -d 'Lists all the installed boxes'
complete -c homestead -f -n '__fish_homestead_using_command_and_no_subcommand box' -a remove -d 'Removes a box from homestead'
complete -c homestead -f -n '__fish_homestead_using_command_and_no_subcommand box' -a repackage -d 'Repackages the given box for redistribution'
complete -c homestead -f -n '__fish_homestead_using_subcommand box add' -l provider -d 'Verifies the box with the given provider'
complete -c homestead -f -n '__fish_homestead_using_subcommand box remove' -a '(__fish_homestead_boxes)'

# connect
complete -c homestead -f -n '__fish_homestead_no_command' -a 'connect' -d 'Connect to a remotely shared homestead environment'
complete -c homestead -f -n '__fish_homestead_using_command connect' -l disable-static-ip -d 'No static IP, only a SOCKS proxy'
complete -c homestead -f -n '__fish_homestead_using_command connect' -l static-ip -r -d 'Manually override static IP chosen'
complete -c homestead -f -n '__fish_homestead_using_command connect' -l ssh -d 'SSH into the remote machine'


# destroy
complete -c homestead -f -n '__fish_homestead_no_command' -a 'destroy' -d 'Destroys the running machine'
complete -c homestead -f -n '__fish_homestead_using_command destroy' -s f -l force -d 'Destroy without confirmation'

# global-status
complete -c homestead -f -n '__fish_homestead_no_command' -a 'global-status' -d 'Global status of homestead environments'
complete -c homestead -f -n '__fish_homestead_using_command global-status' -l prune -d 'Prune invalid entries'

# gem
complete -c homestead -f -n '__fish_homestead_no_command' -a 'gem' -d 'Install homestead plugins through ruby gems'

# halt
complete -c homestead -f -n '__fish_homestead_no_command' -a 'halt' -d 'Shuts down the running machine'
complete -c homestead -f -n '__fish_homestead_using_command halt' -s f -l force -d 'Force shut down'

# init
complete -c homestead -f -n '__fish_homestead_no_command' -a 'init' -d 'Initializes the homestead environment'
complete -c homestead -f -n '__fish_homestead_using_command init' -a '(__fish_homestead_boxes)'

# login
complete -c homestead -f -n '__fish_homestead_no_command' -a 'login' -d 'Log in to homestead Cloud'
complete -c homestead -f -n '__fish_homestead_using_command login ' -s c -l check -d "Only checks if you're logged in"
complete -c homestead -f -n '__fish_homestead_using_command login ' -s k -l logout -d "Logs you out if you're logged in"

# package
complete -c homestead -n '__fish_homestead_no_command' -a 'package' -d 'Packages a running machine into a reusable box'
complete -c homestead -n '__fish_homestead_using_command package' -l base -d 'Name or UUID of the virtual machine'
complete -c homestead -n '__fish_homestead_using_command package' -l output -d 'Output file name'
complete -c homestead -n '__fish_homestead_using_command package' -l include -r -d 'Additional files to package with the box'
complete -c homestead -n '__fish_homestead_using_command package' -l homesteadfile -r -d 'Include the given homesteadfile with the box'

# plugin
complete -c homestead -n '__fish_homestead_no_command' -a 'plugin' -d 'Manages plugins'
complete -c homestead -n '__fish_homestead_using_command plugin' -a install -r -d 'Installs a plugin'
complete -c homestead -n '__fish_homestead_using_command plugin' -a license -r -d 'Installs a license for a proprietary homestead plugin'
complete -c homestead -f -n '__fish_homestead_using_command plugin' -a list -d 'Lists installed plugins'
complete -c homestead -n '__fish_homestead_using_command plugin' -a uninstall -r -d 'Uninstall the given plugin'

# provision
complete -c homestead -n '__fish_homestead_no_command' -a 'provision' -d 'Runs configured provisioners on the running machine'
complete -c homestead -n '__fish_homestead_using_command provision' -l provision-with -r -d 'Run only the given provisioners'

# rdp
complete -c homestead -n '__fish_homestead_no_command' -a 'rdp' -d 'Connects to machine via RDP'

# reload
complete -c homestead -f -n '__fish_homestead_no_command' -a 'reload' -d 'Restarts the running machine'
complete -c homestead -f -n '__fish_homestead_using_command reload' -l no-provision -r -d 'Provisioners will not run'
complete -c homestead -f -n '__fish_homestead_using_command reload' -l provision-with -r -d 'Run only the given provisioners'

# resume
complete -c homestead -x -n '__fish_homestead_no_command' -a 'resume' -d 'Resumes a previously suspended machine'

# share
complete -c homestead -n '__fish_homestead_no_command' -a 'share' -d 'Share your homestead environment with anyone in the world'
complete -c homestead -n '__fish_homestead_using_command share' -l disable-http -d 'Disable publicly visible HTTP endpoint'
complete -c homestead -n '__fish_homestead_using_command share' -l domain -r -d 'Domain the share name will be a subdomain of'
complete -c homestead -n '__fish_homestead_using_command share' -l http -r -d 'Local HTTP port to forward to'
complete -c homestead -n '__fish_homestead_using_command share' -l https -r -d 'Local HTTPS port to forward to'
complete -c homestead -n '__fish_homestead_using_command share' -l name -r -d 'Specific name for the share'
complete -c homestead -n '__fish_homestead_using_command share' -l ssh -d "Allow 'homestead connect --ssh' access"
complete -c homestead -n '__fish_homestead_using_command share' -l ssh-no-password -d "Key won't be encrypted with --ssh"
complete -c homestead -n '__fish_homestead_using_command share' -l ssh-port -r -d 'Specific port for SSH when using --ssh'
complete -c homestead -n '__fish_homestead_using_command share' -l ssh-once -d "Allow 'homestead connect --ssh' only one time"

# ssh
complete -c homestead -f -n '__fish_homestead_no_command' -a 'ssh' -d 'SSH into a running machine'
complete -c homestead -f -n '__fish_homestead_using_command ssh' -s c -l command -r -d 'Executes a single SSH command'
complete -c homestead -f -n '__fish_homestead_using_command ssh' -s p -l plain -r -d 'Does not authenticate'

# ssh-config
complete -c homestead -f -n '__fish_homestead_no_command' -a 'ssh-config' -d 'Outputs configuration for an SSH config file'
complete -c homestead -f -n '__fish_homestead_using_command ssh-config' -l host -r -d 'Name of the host for the outputted configuration'

# status
complete -c homestead -x -n '__fish_homestead_no_command' -a 'status' -d 'Status of the machines homestead is managing'

# suspend
complete -c homestead -x -n '__fish_homestead_no_command' -a 'suspend' -d 'Suspends the running machine'

# up
complete -c homestead -f -n '__fish_homestead_no_command' -a 'up' -d 'Creates and configures guest machines'
complete -c homestead -f -n '__fish_homestead_using_command up' -l provision -d 'Enable provision'
complete -c homestead -f -n '__fish_homestead_using_command up' -l no-provision -d 'Disable provision'
complete -c homestead -f -n '__fish_homestead_using_command up' -l provision-with -r -d 'Enable only certain provisioners, by type'