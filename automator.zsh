#
# Automator-specific scripts, functions and aliases
#

_add_function set-workflow-types "Manage Automator Quick Action file types"
function set-workflow-types() {
    emulate -L zsh
    setopt local_options no_nomatch

    local services_dir="$HOME/Library/Services"
    local pbs="/System/Library/CoreServices/pbs"

    # ─────────────────────────────────────────────────────────
    # Help
    # ─────────────────────────────────────────────────────────

    function _swt_help() {
        cat <<'EOF'
set-workflow-types — Manage Automator Quick Action file types

USAGE
  set-workflow-types <UTI[,UTI...]> <workflow> [workflow...]
  set-workflow-types --list [workflow...]
  set-workflow-types --help

COMMANDS
  <UTI[,UTI...]>   Set accepted file types for one or more workflows.
  --list           Display workflows and their accepted file types.
  --help, -h       Display this help message.

WORKFLOW NAMES
  Workflow arguments can be:

  - A workflow name (resolved in ~/Library/Services)
  - A workflow filename ending in .workflow
  - An absolute or relative path to a .workflow bundle

  Names containing spaces must be quoted.

FILE TYPES
  File types are specified using Uniform Type Identifiers (UTIs).

  Common identifiers:

    public.png                  PNG images
    public.jpeg                 JPEG images
    public.heic                 HEIC images
    public.image                All image types
    public.pdf                  PDF documents
    public.plain-text           Plain text
    public.text                 Text documents
    net.daringfireball.markdown Markdown files

  Multiple types may be specified using commas (no spaces).

EXAMPLES
  Restrict a workflow to PNG files:

    set-workflow-types public.png "Optimize PNG"

  Update multiple workflows:

    set-workflow-types public.png \
      "Optimize PNG" \
      "Compress PNG" \
      "Copy & Optimize PNG" \
      "Copy & Compress PNG"

  Accept PNG and JPEG images:

    set-workflow-types public.png,public.jpeg "Process Images"

  Restrict a Markdown workflow:

    set-workflow-types net.daringfireball.markdown "Markdown to PDF"

  Use an explicit path:

    set-workflow-types public.png \
      "$HOME/Desktop/My Workflow.workflow"

  List all workflows:

    set-workflow-types --list

  List specific workflows:

    set-workflow-types --list "Optimize PNG" "Compress PNG"

NOTES
  - Modifies NSServices[0].NSSendFileTypes in Contents/Info.plist.
  - Creates a backup before modifying each workflow.
  - Validates the updated property list.
  - Refreshes the macOS Services cache after changes.
  - Does not modify workflow actions or scripts.
  - Saving a workflow in Automator may reset its file types.
  - Finder ultimately controls Quick Action visibility.

  To identify a file's UTI:

    mdls -name kMDItemContentType /path/to/file

EOF
    }

    # ─────────────────────────────────────────────────────────
    # Resolve workflow path
    # ─────────────────────────────────────────────────────────

    function _swt_resolve() {
        local workflow="$1"

        if [[ "$workflow" != */* ]]; then
            workflow="$services_dir/$workflow"
        fi

        [[ "$workflow" == *.workflow ]] || workflow+=".workflow"

        print -r -- "$workflow"
    }

    # ─────────────────────────────────────────────────────────
    # Read accepted file types
    # ─────────────────────────────────────────────────────────

    function _swt_get_types() {
        local plist="$1"
        local json

        if [[ ! -f "$plist" ]]; then
            print -- "—"
            return
        fi

        json=$(plutil -extract NSServices.0.NSSendFileTypes \
            json -o - "$plist" 2>/dev/null) || {
            print -- "—"
            return
        }

        # Extract JSON string values using Zsh.
        # UTIs contain only simple identifier characters.
        local -a types
        types=(${(f)"$(print -r -- "$json" |
            grep -oE '"[A-Za-z0-9._-]+"' |
            tr -d '"')"})

        if (( ${#types[@]} > 0 )); then
            print -- "${(j:, :)types}"
        else
            print -- "—"
        fi
    }

    # ─────────────────────────────────────────────────────────
    # List workflows
    # ─────────────────────────────────────────────────────────

    function _swt_list() {
        local -a workflows
        local workflow plist name types
        local found=0
        local explicit=0

        if (( $# > 0 )); then
            explicit=1

            for workflow in "$@"; do
                workflows+=("$(_swt_resolve "$workflow")")
            done
        else
            workflows=("$services_dir"/*.workflow(N))
        fi

        print
        printf '%-38s %s\n' \
            "WORKFLOW" "ACCEPTED FILE TYPES"

        printf '%-38s %s\n' \
            "--------------------------------------" \
            "------------------------------------------"

        for workflow in "${workflows[@]}"; do
            plist="$workflow/Contents/Info.plist"
            name="${${workflow:t}%.workflow}"

            if [[ ! -f "$plist" ]]; then
                if (( explicit )); then
                    printf '%-38s %s\n' "$name" "[Not found]"
                fi
                continue
            fi

            types=$(_swt_get_types "$plist")

            printf '%-38s %s\n' "$name" "$types"

            (( found++ ))
        done

        print
        print "$found workflow(s) listed."
    }

    # ─────────────────────────────────────────────────────────
    # Parse commands
    # ─────────────────────────────────────────────────────────

    case "${1:-}" in
        --help|-h)
            _swt_help
            return 0
            ;;

        --list)
            shift
            _swt_list "$@"
            return 0
            ;;

        "")
            _swt_help >&2
            return 1
            ;;
    esac

    # ─────────────────────────────────────────────────────────
    # Validate arguments
    # ─────────────────────────────────────────────────────────

    if (( $# < 2 )); then
        print -u2 "Error: Expected file types and at least one workflow."
        print -u2 "Run 'set-workflow-types --help' for usage."
        return 1
    fi

    local -a types
    types=("${(@s:,:)1}")
    shift

    if (( ${#types[@]} == 0 )); then
        print -u2 "Error: No file types specified."
        return 1
    fi

    # Construct JSON array.
    local json="["
    local type

    for type in "${types[@]}"; do
        if [[ ! "$type" =~ '^[A-Za-z0-9._-]+$' ]]; then
            print -u2 "Error: Invalid UTI: $type"
            return 1
        fi

        [[ "$json" != "[" ]] && json+=","
        json+="\"$type\""
    done

    json+="]"

    # ─────────────────────────────────────────────────────────
    # Update workflows
    # ─────────────────────────────────────────────────────────

    local updated=0
    local failed=0

    local workflow plist name backup actual
    local -a actual_types

    for workflow in "$@"; do
        workflow=$(_swt_resolve "$workflow")
        plist="$workflow/Contents/Info.plist"
        name="${${workflow:t}%.workflow}"

        if [[ ! -f "$plist" ]]; then
            print -u2 "✗ Not found: $plist"
            (( failed++ ))
            continue
        fi

        # Validate plist and NSServices entry.
        if ! plutil -lint -s "$plist" ||
           ! plutil -extract NSServices.0 json -o - \
               "$plist" >/dev/null 2>&1; then

            print -u2 "✗ Invalid workflow service: $name"
            (( failed++ ))
            continue
        fi

        # Create backup.
        backup=$(mktemp "$plist.backup.XXXXXX") || {
            print -u2 "✗ Could not create backup: $name"
            (( failed++ ))
            continue
        }

        if ! cp -p "$plist" "$backup"; then
            rm -f "$backup"
            print -u2 "✗ Backup failed: $name"
            (( failed++ ))
            continue
        fi

        # Update property list.
        if plutil -replace NSServices.0.NSSendFileTypes \
            -json "$json" "$plist" &&
           plutil -lint -s "$plist"; then

            # Verify semantic value instead of raw JSON formatting.
            actual=$(_swt_get_types "$plist")
            local expected="${(j:, :)types}"

            if [[ "$actual" == "$expected" ]]; then
                print "✓ Updated: $name"
                print "  Types: $expected"
                print "  Backup: $backup"

                (( updated++ ))
                continue
            fi
        fi

        # Restore original on failure.
        if cp -p "$backup" "$plist"; then
            print -u2 "✗ Update failed; original restored: $name"
        else
            print -u2 "✗ Update failed; restore failed: $name"
            print -u2 "  Restore manually from: $backup"
        fi

        (( failed++ ))
    done

    # ─────────────────────────────────────────────────────────
    # Refresh macOS Services
    # ─────────────────────────────────────────────────────────

    if (( updated > 0 )); then
        print
        print "Refreshing macOS Services..."

        if [[ -x "$pbs" ]]; then
            if "$pbs" -flush; then
                print "Services cache refreshed."
            else
                print -u2 "Warning: Could not refresh Services cache."
            fi
        else
            print -u2 "Warning: Services refresh utility not found."
        fi
    fi

    print
    print "Complete: $updated updated, $failed failed."

    (( failed == 0 ))
}
