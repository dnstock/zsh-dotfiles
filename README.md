# Custom Shell Scripts and Aliases

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-zsh-green.svg)

A collection of productivity-boosting shell aliases and functions to enhance your command-line experience, with focus on:
- File system navigation
- Network operations
- System maintenance
- Development workflows

## Features

- 🚀 Smart functions and aliases with documentation
- 🔍 Built-in help system (`function_info`, `alias_info`)
- 🛠 System maintenance utilities
- 🌐 Network troubleshooting tools
- 📁 Enhanced file operations
- 💻 Development workflow helpers

## Prerequisites

- ZSH shell
- [LSD](https://github.com/lsd-rs/lsd) for enhanced file listing (optional)

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

## Installation

### Oh My Zsh Users

Clone and copy to custom directory:
```bash
    git clone https://github.com/yourusername/repo-name.git
    cp -r repo-name/* ~/.oh-my-zsh/custom/
```

### Standard ZSH Users

Clone and source in your .zshrc:
```bash
    git clone https://github.com/yourusername/repo-name.git
    echo "source ~/path/to/repo-name/*.zsh" >> ~/.zshrc
```

### Bash and Other Shell Users
The scripts should function correctly with minor modifications:
- Replace `typeset` with `declare` (for Bash)
- Adjust code blocks marked Zsh-specific
- Adjust array syntax where needed

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

## Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) for inspiration and compatibility
- [LSD](https://github.com/lsd-rs/lsd) for enhanced file listing
