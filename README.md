# NIX

## General storage structure

### Local storage (`Temporary` files)

* Temp files
* Downloads
* macOS workflows `~/Library/Services`

### iCloud (`Personal` files)

* Everything important (personal)
* Scripts (auto synced)

### Google Drive (`Shared`)

* Google docs
* House


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

Whenever adding or updating flakes run

```bash
nix flake update
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