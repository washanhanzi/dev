# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# homebrew
let-env PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')

# go
let-env PATH = ($env.PATH | split row (char esep) | append '/usr/local/go/bin')

# bin
let-env PATH = ($env.PATH | split row (char esep) | append '/usr/local/bin/')

# vscode
let-env PATH = ($env.PATH | split row (char esep) | append '/Applications/Visual Studio Code.app/Contents/Resources/app/bin')

# rust
let-env PATH = ($env.PATH | split row (char esep) | append '/Users/jingyu/.cargo/bin')

# proxy
let-env http_proxy = 'http://localhost:7890'
let-env https_proxy = 'http://localhost:7890'
let-env NO_PROXY = 'localhost,127.0.0.1,::1'

#pnpm
let pnpm_home = '/Users/jingyu/Library/pnpm'
let-env PNPM_HOME = $pnpm_home
let-env PATH = ($env.PATH | split row (char esep) | append $pnpm_home)

# starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# zoxide
zoxide init nushell | save -f ~/.zoxide.nu

