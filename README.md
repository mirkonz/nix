# NIX

## Install

[Install Determinate Nix on macOS](https://install.determinate.systems/determinate-pkg/stable/Universal)

Then run
```sh
curl -fsSL https://raw.githubusercontent.com/mirkonz/nix/main/install.sh | sudo sh


## Entry file
- `./flake.nix`


### Manual rerun
```bash
nixup
```

### Clear cache
```bash
rm -rf ~/.cache/nix
rm -f ~/.zcompdump*
```

### Delete old garbage
```bash
nix-collect-garbage -d
```

### Delete store
```bash
nix-store --gc
```