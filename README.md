# git-ignore

git-ignore is a tool to help with managing gitignore files for git.

## Installation

Clone the repository to whereever you want then run the installation script.

```sh
    cd /tmp
    git clone https://github.com/Archangel33/git-ignore.git git-ignore
    install.sh
```

Note: this will install the scripts to the default git directory /usr/bin/git-core. If
you want to install the extensions to another location just provide your perfered directery.

```sh
    cd /tmp
    git clone https://github.com/Archangel33/git-ignore.git git-ignore
    install.sh /usr/bin
```

## Usage

ex: Display a list of files that are currently being ignored in this repo

```sh
    git ignore list
```

ex: Add a pattern to be ignored by git (for patterns relative to CWD)

```sh
    git ignore add "~*"
```

ex: Edit patterns to be ignored by git manually

```sh
    git ignore edit
```

Run `git-ignore -h | --help` for full usage

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

See CHANGELOG File

## Credits

See AUTHORS File

## License

See LICENSE File
