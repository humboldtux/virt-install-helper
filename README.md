# virt-install Helper

A helper script to easily create and launch a VM with `virt-install`.

User is interactively prompted for common options thanks to [Gum](https://github.com/charmbracelet/gum).

<img width="800" src="./resources/vhs.gif" />

# Usage

Simply execute the script with no argument:

```sh
./virtinstall-helper.sh
```

If you want to pass a custom directory to search for iso files (`~/Documents` by default),
just pass it on the command line as `ISODIR`, e.g.:

```sh
ISODIR="/tmp" ./virtinstall-helper.sh
```

# Resources

The gif is created with [VHS](https://github.com/charmbracelet/vhs):

```sh
vhs < ./resources/vhs.tape
```
