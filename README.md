# Custom Shell Scripts and Aliases

This is a collection of helpful shell scripts and aliases that I've created to enhance your command-line experience.

## Installation

### Oh My Zsh Users

If you're using [Oh My Zsh](https://ohmyz.sh/), simply place these files in your `~/.oh-my-zsh/custom/` directory, and you're all set:

```bash
cp -r * ~/.oh-my-zsh/custom/
```

### Zsh Users Without Oh My Zsh

For those using Zsh without Oh My Zsh, this code should work unmodified. Just source it in your `.zshrc` or `.zsh_profile` file:

```bash
source /path/to/your/script.zsh
```

### Bash and Other Shell Users

If you're using Bash or another shell, minor code adjustments might be necessary (such as changing `typeset` to `declare`). After making these changes, the scripts should function correctly.

## Other Dependencies

A few aliases depend on the `lsd` package. Alternate versions are also provided which use the classic `ls` command if you prefer.

You can install it with Homebrew:
```bash
brew install lsd
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License

This code is licensed under the [MIT License](LICENSE).
