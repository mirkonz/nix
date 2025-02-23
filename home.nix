{ pkgs, username, mac-app-util, ... }:
{
  imports = [
    mac-app-util.homeManagerModules.default
  ];
  home = {
    username = "${username}";
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
    sessionVariables = {
      NIX_TRAMPOLINE = "1";
    };
    packages = with pkgs; [
      # CLI tools
      bat # fancy version of `cat`
      curl
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
      pnpm
      rbenv
      ripgrep # fancy version of `grep`
      rsync
      skhd
      ssh-copy-id
      tmux
      tree
      wget
      yq
      zsh
      zinit

      # GUI apps
      arc-browser
      docker
      discord
      # firefox # Broken
      google-chrome
      iina
      # iterm2
      keka
      # obs-studio # Broken
      raycast
      signal-desktop
      spotify
      # teams # Broken
      vscode
      zoom
    ];
    file = {
      ".gitconfig".source = ./dotfiles/.gitconfig;
      ".gitignore_global".source = ./dotfiles/.gitignore_global;
      ".npmrc".source = ./dotfiles/.npmrc;
      ".p10k.zsh".source = ./dotfiles/.p10k.zsh;
      ".powerlevel9k".source = ./dotfiles/.powerlevel9k;
      ".vimrc".source = ./dotfiles/.vimrc;
      ".zshrc".source = ./dotfiles/.zshrc;
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "Mirko May";
      userEmail = "hi@mirko.nz";
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        reload = "source /Users/${username}/.zshrc; echo -e \"\ue2a2 Done!\"";
        nixup = "darwin-rebuild switch --flake ~/.config/nix";

        t = "eza -Tl --icons";
        tree = "eza -T --icons";
        vi = "nvim";
        vim = "nvim";
        _vim = "vi";
        cat = "bat";
        mk = "take";
        md = "take";
        ytd = "yt-dlp";
      };
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}