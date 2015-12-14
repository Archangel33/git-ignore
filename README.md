# git-ignore

git-ignore is a tool to help with managing gitignore files for git.

## Installation

Clone the repository into your /usr/lib/git-core direcory or a directory on your path.
ex: basic install
```
$ git clone https://github.com/Archangel33/git-ignore.git <path to desired installation>
```
From here either add <path to desired installation> to the $PATH environment var or copy the git-ignore-* files to /usr/lib/git-core/

### complete installations
ex: Install for current user
```
    $ mkdir -p ~/git/bin
    $ cd ~/git/bin
    $ git clone https://github.com/Archangel33/git-ignore.git git-ignore
    $ export PATH=~/git/bin/git-ignore:$PATH
```
ex: Install for all users
```
    $ cd /tmp
    $ git clone https://github.com/Archangel33/git-ignore.git git-ignore
    $ cp ./git-ignore/git-ignore-* /usr/lib/git-core/
```

optionally remove /tmp/git-ignore
```
    $ rm /tmp/git-ignore
```
## Usage

ex: Display a list of files that are currently being ignored in this repo

    $ git ignore list

ex: Add a pattern to be ignored by git (for patterns relative to CWD)

    $ git ignore add "~*"

ex: Edit patterns to be ignored by git manually

    $ git ignore edit

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
