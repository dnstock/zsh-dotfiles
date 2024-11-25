#
# General-use personal shell functions
#

add_function force_eject "Force eject a disk by unmounting it first"
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

add_function find_proc "Find processes using a drive, port, file, directory, or network connection"
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
        drive)
            lsof | grep $2
            ;;
        port)
            lsof -i :$2
            ;;
        file)
            lsof | grep $2
            ;;
        dir)
            lsof | grep $2
            ;;
        net)
            lsof -i $2
            ;;
        *)
            echo "Invalid type: $1"
            echo "----------------------------------------"
            echo "Types: drive, port, file, dir, net"
            return 1
            ;;
    esac
}
