# Custom Shell Scripts and Aliases

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-zsh-green.svg)

### Starter Collection

This repo provides a collection of helpful custom aliases and functions for the ZSH shell and Oh My Zsh, including:

- File system navigation
- Network operations
- System maintenance
- [Homebrew](https://brew.sh/) helpers
- Development workflows

### Extensible Framework

It also creates a framework to add new custom functions and aliases (`_add_function`, `_add_alias`) with built-in documentation (`function_info`, `alias_info`), and plays nicely with the global namespace.

## Installation

### Oh My Zsh (preferred)

Clone into custom directory:
```bash
    git clone https://github.com/dnstock/zsh-dotfiles.git ~/.oh-my-zsh/custom/
```

### Standard ZSH

Though [Oh My Zsh](https://ohmyz.sh/) is preferred, you can also clone and source in your .zshrc:
```bash
    git clone https://github.com/dnstock/zsh-dotfiles.git
    echo "source ./zsh-dotfiles/*.zsh" >> ~/.zshrc
```

### Bash and Other Shells
The scripts should function correctly with minor modifications:
- Replace `typeset` with `declare` (for Bash)
- Adjust code blocks marked Zsh-specific
- Adjust array syntax where needed

## Optional Addition

[LSD](https://github.com/lsd-rs/lsd) is optional. If installed, it will be used to further enhance file listing.

### LSD Installation
```bash
    brew install lsd
```

### LSD Configuration
An `lsd_config.yaml` file can be used to manage configuration from within this repository.

Create a configuration file from the included example file:
```
cp lsd_config.example.yaml lsd_config.yaml
```

When LSD is detected, this configuration will be automatically symlinked to `~/.config/lsd/config.yaml`.

If an existing configuration is detected, it will not be overwritten. Please delete the existing `config.yaml` file if you prefer to use `lsd_config.yaml`.

## Usage

### List Available Commands

View available aliases or function:
```bash
    alias_info --help
    function_info --help
```

View all aliases or functions:
```bash
    alias_info --all
    function_info --all
```

View specific alias or functions:
```bash
    alias_info netinfo
    function_info find_proc
```

### Example Aliases

    ll      # Enhanced directory listing
    netinfo # Show network interface details
    tree    # Display directory structure

## Structure

    .
    ├── 0_init.zsh         # Core declarations
    ├── 1_aliases.zsh      # General aliases
    ├── 2_functions.zsh    # General functions
    ├── lsd_config.yaml    # LSD configuration (optional)
    ├── [...]              # Scope-specific scripts
    └── zz_end.zsh         # Clean up and summarize

Script files get processed in alphabetical order.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -am 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
