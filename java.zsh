#
# Java specific scripts and aliases
#

# http://superuser.com/questions/490425/how-do-i-switch-between-java-7-and-java-6-on-os-x-10-8-2
add_alias java_ls "/usr/libexec/java_home -V 2>&1 | grep -Eo '^\s*\d+\.\d+\.\d+ ' | cut -d , -f 1 | colrm 1 4 | grep -v Home" "List available Java versions"

function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}
add_function java_use "Switch between Java versions on the fly (ex: java_use 1.8)"

export JAVA_HOME=$(/usr/libexec/java_home) # remove the ' -v x.x' part to use latest version of Java
export PATH=$JAVA_HOME/bin:$PATH
