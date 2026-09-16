#
# General-use personal shell functions
#

_add_function force_eject "Force eject a disk by unmounting it first"
_add_function ver "Get the installed version of a specific application"
function ver() {
    if [ -z "$1" ]; then
        echo "Usage: ver <Application Name>"
        echo "Example: ver Safari"
        return 1
    fi
    mdls -name kMDItemVersion /Applications/"$1".app
}

# NOTE: Upon process termination, caffeinate will automatically stop, returning the system to its normal sleep behavior.
_add_function nosleep "Prevent the system from sleeping while a specified process or application is running"
function nosleep() {
    if [[ -z "$1" ]]; then
        echo "Usage: nosleep <process_name>"
        echo "Example: nosleep Music"
        return 1
    fi
    # Fetch the PID for the specified process name
    local pid=$(pgrep -x "$1" | head -n 1)
    if [[ -n "$pid" ]]; then
        # Launch caffeinate disowned from zsh job control
        { caffeinate -d -i -m -s -w "$pid" >/dev/null 2>&1 } &!
        echo "Preventing system sleep while $1 is running (PID: $pid)"
        echo "=> run 'pgrep caffeinate' to terminate manually"
    else
        echo "$1 is not running. Please start the process first."
        return 1
    fi
}

function force_eject() {
    if [ -z "$1" ]; then
        echo "Usage: forceEject <disk>"
        echo "Example: forceEject /dev/disk2"
        echo "Use 'diskutil list' to list all disks"
        return 1
    fi
    # Check if disk is mounted
    if [ -z "$(diskutil list | grep $1)" ]; then
        echo "Disk not found: $1"
        echo "----------------------------------------"
        echo "Usage: forceEject <disk>"
        echo "Example: forceEject /dev/disk2"
        echo "Use 'diskutil list' to list all disks"
        return 1
    fi
    # Unmount and eject disk
    diskutil unmount force $1
    diskutil eject $1
}

_add_function find_proc "Find processes using a drive, port, file, directory, or network connection"
function find_proc() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: findProc <type> <string>"
        echo "Example: findProc drive /dev/disk2"
        echo "Example: findProc port 8080"
        echo "Example: findProc file /path/to/file"
        echo "Example: findProc dir /path/to/directory"
        echo "Example: findProc net 8080"
        echo "----------------------------------------"
        echo "Types: drive, port, file, dir, net"
        return 1
    fi
    case $1 in
        port)
            lsof -i :$2
            ;;
        net)
            lsof -i $2
            ;;
        drive|file|dir)
            lsof | grep $2
            ;;
        *)
            echo "Usage: $0 <drive|port|file|dir|net> <pattern>"
            return 1
            ;;
    esac
}
