{ pkgs, ... }:

{
  # Core system packages (always available)
  systemPackages = with pkgs; [
    binutils
    coreutils
    diffutils
    curl
    wget
    rsync
    tmux
    tree
    dockutil
  ];

  # User-level packages (Home Manager) development tools
  userPackages = with pkgs; [
    bat # fancy version of `cat`
    direnv
    eza
    fd # fancy version of `find`
    ffmpeg
    fzf
    htop
    imagemagick
    jq
    m-cli
    mc
    neovim
    nixfmt-rfc-style
    pnpm
    rbenv
    ripgrep # fancy version of `grep`
    rsync
    skhd
    ssh-copy-id
    yq # YAML, JSON, XML processor
    zsh-powerlevel10k
    zinit
    zsh-fzf-tab
  ];

  # Homebrew packages (macOS-native tools)
  homebrewPackages = [
    "colima"
    "python"
    "docker"
    "docker-completion"
    "dockutil"
    "nvm"
    "yt-dlp" # youtube-dl fork
  ];

  homebrewCaskPackages = [
    "affinity-designer"
    "affinity-photo"
    "apptrap"
    "arc"
    "balenaetcher"
    "bartender"
    "bettertouchtool"
    "chatgpt"
    "cleanmymac"
    "commander-one"
    "discord"
    "drawio"
    "dropbox"
    "easyfind"
    "firefox"
    "google-chrome"
    "google-drive"
    "handbrake"
    "iina"
    "imageoptim"
    "iterm2"
    "itsycal"
    "keepassxc"
    "keka"
    "microsoft-outlook"
    "microsoft-teams"
    "music-decoy"
    "namechanger"
    "obs"
    "plex"
    "raycast"
    "rectangle"
    "screens-connect"
    "signal"
    "slack"
    "sparrow"
    "spotify"
    "spotmenu"
    "stats"
    # "steam"
    "visual-studio-code"
    "whatsapp"
    "xnviewmp"
    "zoom"
  ];

  masPackages = {
    # "Amphetamine" = 937984704;
    # "AutoMounter" = 1160435653;
    # "Boxy SVG" = 611658502;
    # "ColorSlurp" = 1287239339;
    # "DaVinci Resolve" = 571213070;
    # "Hand Mirror" = 1502839586;
    # # "Little Ipsum"                = 405772121;
    # "Tailscale" = 1475387142;
    # "VPN Unlimited - WiFi Proxy" = 727593140;
    # "Windows App" = 1295203466;
  };

  safariWebApps = [
    { url = "https://youtube.com"; name = "YouTube"; }
    { url = "https://soundcloud.com"; name = "SoundCloud"; }
    { url = "https://twitch.tv"; name = "Twitch"; }
    { url = "https://home.2e.nz"; name = "Home Assistant"; }
    { url = "https://sabnzbd.2e.nz/sabnzbd/"; name = "SABnzbd"; }
    { url = "https://prowlarr.2e.nz/search"; name = "Prowlarr"; }
    { url = "https://radarr.2e.nz"; name = "Radarr"; }
    { url = "https://sonarr.2e.nz"; name = "Sonarr"; }
    { url = "https://readarr.2e.nz"; name = "Readarr"; }
    { url = "https://bazarr.2e.nz"; name = "Bazarr"; }
  ];
}
