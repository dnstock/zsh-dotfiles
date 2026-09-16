#
# Java-specific scripts and aliases
#
_add_alias jv "java -version" "Show current Java version"
_add_alias jdk_version "sdk current java" "Show current Java version with SDKMAN"

# http://superuser.com/questions/490425/how-do-i-switch-between-java-7-and-java-6-on-os-x-10-8-2
_add_alias java_ls "/usr/libexec/java_home -V 2>&1 | grep -Eo '^\s*\d+\.\d+\.\d+ ' | cut -d , -f 1 | colrm 1 4 | grep -v Home" "List available Java versions"

# SDKMAN list of installed JDKs
_add_alias jdk_ls "sdk list java | grep installed | awk '{print \$NF}'" "List installed Java versions with SDKMAN"

function __myzsh_get_full_version() {
    # Allow use of major version only (e.g. 11) or full version (e.g. 11.0.11-open)
    if [[ $1 =~ ^[0-9]+$ ]]; then
        local full_version
        full_version=$(sdk list java | grep -E "installed.*\| $1\..+$" | awk '{print $NF}')
        if [[ -z $full_version ]]; then
            echo "No installed Java version found for major version $1"
            return 1
        fi
        echo "$full_version"
    else
        echo "$1"
    fi
}

_add_function java_use "Switch between Java versions on the fly (ex: java_use 1.8)"
function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}

_add_function jdk_use "Switch between Java versions installed with SDKMAN (ex: jdk_use 21 or jdk_use 21.0.8-tem)"
function jdk_use() {
    local full_version
    # if no argument provided, show usage
    if [[ -z $1 ]]; then
        echo 'Usage: jdk_use <major_version> or jdk_use <full_version>'
        return 1
    fi
    full_version=$(__myzsh_get_full_version $1) || return 1
    sdk use java "$full_version"
    java -version
}

_add_function jdk_default "Set default Java version installed with SDKMAN (ex: jdk_default 21 or jdk_default 21.0.8-tem)"
function jdk_default() {
    local full_version
        # if no argument provided, show usage
        if [[ -z $1 ]]; then
            echo 'Usage: jdk_default <major_version> or jdk_use <full_version>'
            return 1
        fi
        full_version=$(__myzsh_get_full_version $1) || return 1
        sdk default java "$full_version"
        java -version
}

export JAVA_HOME=$(/usr/libexec/java_home)  # remove the ' -v x.x' part to use latest version of Java
export PATH=$JAVA_HOME/bin:$PATH
