#
# General-use personal shell aliases
#

#----------------------------------------------
# Filesystem Operations
#----------------------------------------------

# Use lsd if available
if _function_exists lsd; then
    _add_alias ll 'lsd -la' 'List files in long format, including hidden files (using lsd)'
    _add_alias lls 'lsd -la | egrep -i' 'Lists files and directories containing a string, case-insensitive (using lsd)'
    _add_alias tree 'lsd --tree --depth 2' 'Display directory structure of current path two levels deep (using lsd)'
    # Non-lsd options
    _add_alias ll0 'ls -lah' 'List files in long format, including hidden files (using ls)'
    _add_alias lls0 'ls -lah | grep -i' 'Lists files and directories containing a string, case-insensitive (using ls)'
else
    _add_alias ll 'ls -lah' 'List files in long format, including hidden files'
    _add_alias lls 'ls -lah | grep -i' 'Lists files containing a string (case-insensitive)'
    if _function_exists tree; then
        _add_alias tree 'tree -L 2' 'Display directory structure of current path two levels deep'
    fi
fi

#----------------------------------------------
# System Operations
#----------------------------------------------

_add_alias killfinder 'killall Finder' 'Relaunch Finder (releases drive and file locks)'
_add_alias flushdns 'sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder' 'Flushes the DNS cache (using dscacheutil)'
_add_alias flushdns0 'sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache' 'Flushes the DNS cache (using killall)'
_add_alias diskspace 'df -h' 'Show disk space usage for all mounted volumes'
_add_alias disklist 'diskutil list' 'List all disks and partitions'
_add_alias mounts 'df -h && echo "\nDetailed mounts:" && mount | column -t' 'List all mounted volumes with disk usage information'

#----------------------------------------------
# Hardware Information
#----------------------------------------------

_add_alias usbinfo 'system_profiler SPUSBDataType' 'Output hardware profile for USB ports'

#----------------------------------------------
# Network Operations
#----------------------------------------------

_add_alias netlist 'networksetup -listallhardwareports' 'List all network interfaces'
_add_alias netinfo 'ifconfig -a && echo "\nIP Addresses:" && ipconfig getifaddr en0' 'Show network interface details and current IP addresses'
_add_alias netcons 'lsof -i -n -P | grep ESTABLISHED' 'List all established network connections (using lsof)'
_add_alias netcons0 'netstat -an' 'List all network connections (using netstat)'
_add_alias lsports 'lsof -i -n -P | grep TCP' 'List all open TCP ports'
_add_alias pcurl 'curl --proxy localhost:8888' 'Curl with proxy set to localhost:8888'
