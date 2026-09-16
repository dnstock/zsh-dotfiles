#
# Supabase-specific scripts and aliases
#

# Per notice: https://supabase.com/docs/guides/local-development
_add_function supabase-start-local "Start Supabase with a local network ID"
function supabase-start-local() {
    # Restrict network access to only this localhost machine
    if ! docker network ls | grep -q local-network; then
        echo "Creating local Docker network 'local-network' with host binding to 127.0.0.1"
        docker network create -o 'com.docker.network.bridge.host_binding_ipv4=127.0.0.1' local-network
    fi
    supabase start --network-id local-network
}
