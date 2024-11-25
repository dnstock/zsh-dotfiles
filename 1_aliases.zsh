#
# General-use personal shell aliases
#

#----------------------------------------------
# Filesystem Operations
#----------------------------------------------

add_alias ll 'lsd -la' 'List files (using lsd) in long format, including hidden files'
add_alias ll0 'ls -lah' 'List files (using ls) in long format, including hidden files'
add_alias lls 'lsd -la | grep -i' 'Lists files (using lsd) containing a string (case-sensitive)'
add_alias lls0 'll -d' 'Lists files (using ls) containing a string (note: will NOT list hidden files/directories)'
add_alias tree 'lsd --tree --depth 2' 'Display directory structure'

#----------------------------------------------
# System Operations
#----------------------------------------------

add_alias killfinder 'killall Finder' 'Relaunch Finder (releases drive and file locks)'
add_alias flushdns 'sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder' 'Flushes the DNS cache (using dscacheutil)'
add_alias flushdns0 'sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache' 'Flushes the DNS cache (using killall)'
add_alias diskspace 'df -h' 'Show disk space usage for all mounted volumes'
add_alias disklist 'diskutil list' 'List all disks and partitions'
add_alias mounts 'df -h && echo "\nDetailed mounts:" && mount | column -t' 'List all mounted volumes with disk usage information'

#----------------------------------------------
# Hardware Information
#----------------------------------------------

add_alias usbinfo 'system_profiler SPUSBDataType' 'Output hardware profile for USB ports'

#----------------------------------------------
# Network Operations
#----------------------------------------------

add_alias netlist 'networksetup -listallhardwareports' 'List all network interfaces'
add_alias netinfo 'ifconfig -a && echo "\nIP Addresses:" && ipconfig getifaddr en0' 'Show network interface details and current IP addresses'
add_alias netcons 'lsof -i -n -P | grep ESTABLISHED' 'List all established network connections (using lsof)'
add_alias netcons0 'netstat -an' 'List all network connections (using netstat)'
add_alias lsports 'lsof -i -n -P | grep TCP' 'List all open TCP ports'
add_alias pcurl 'curl --proxy localhost:8888' 'Curl with proxy set to localhost:8888'
