{
  pkgs,
  lib,
  username,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs; };
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

  safariWebAppCommands = lib.concatStringsSep "\n" (map (app:
    ''
    osascript ~/Library/Mobile\\ Documents/com~apple~CloudDocs/Scripts/create-safari-webapp.applescript "${app.url}" "${app.name}"
    ''
  ) safariWebApps);
in
{
  # Home Manager settings
  home-manager.users.${username} = { pkgs, lib, ...}: {
    home.username = username;
    home.homeDirectory = "/Users/${username}";
    home.stateVersion = "23.11";

    home.sessionVariables = {
      ZDOTDIR = "$HOME";
      EDITOR = "code";
    };

    # Home Manager managed packages
    home.packages = packages.userPackages;

    # Dotfiles
    home.file = {
      ".gitconfig".source = ./dotfiles/.gitconfig;
      ".gitignore_global".source = ./dotfiles/.gitignore_global;
      ".hushlogin".source = ./dotfiles/.hushlogin;
      ".npmrc".source = ./dotfiles/.npmrc;
      ".p10k.zsh".source = ./dotfiles/.p10k.zsh;
      ".vimrc".source = ./dotfiles/.vimrc;
      ".functions.zsh".source = ./dotfiles/.functions.zsh;
      ".zinit.zsh".source = ./dotfiles/.zinit.zsh;
    };

    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName = "Mirko May";
        userEmail = "hi@mirko.nz";
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      # Zsh configuration
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          # reload = "source ~/.zshrc";
          reload = "exec zsh; echo -e \"$(random_icon)  Done!\"";
          edit = "$EDITOR $HOME/nix";
          hosts = "sudo $EDITOR /etc/hosts";

          nixup = "nix run nix-darwin -- switch --flake .#mirko";

          l = "eza -bGF --header --git --color=always --group-directories-first --icons";
          ls = "eza --header --git --color=always --group-directories-first --icons";
          ll = "eza -la --header --git --icons --octal-permissions --group-directories-first";
          llm = "eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons";
          la = "eza --long --all --group --group-directories-first";
          lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";

          lS = "eza -1 --color=always --group-directories-first --icons";
          lt = "eza --tree --level=2 --color=always --group-directories-first --icons";
          # l. = "eza -a | grep -E '^\.'";

          t = "eza -Tl --icons";
          tree = "eza -T --icons";

          vi = "nvim";
          vim = "nvim";
          _vim = "vi";

          cat = "bat";

          ytd = "yt-dlp";
        };
        initContent = ''
          # Functions
          [[ ! -f ~/.functions.zsh ]] || source ~/.functions.zsh

          # Greeting
          echo -e "Hi ${username}!  $(random_icon)"

          # Powerlevel10k
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

          # ZINIT
          source ${pkgs.zinit}/share/zinit/zinit.zsh
          [[ ! -f ~/.zinit.zsh ]] || source ~/.zinit.zsh

          # FZF tab
          source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

          # NVM NODE
          [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
          [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
          autoload -U add-zsh-hook
          load-nvmrc() {
              if [[ -f .nvmrc && -r .nvmrc ]]; then
                  nvm use
              elif [[ $(nvm version) != $(nvm version default) ]]; then
                  echo "Reverting to nvm default version"
                  nvm use default
              fi
          }
          add-zsh-hook chpwd load-nvmrc
          load-nvmrc

          # RUBY
          eval "$(rbenv init -)"
        '';
      };
    };

    # Run the AppleScript for each web app
    home.activation.createSafariWebApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${safariWebAppCommands}
    '';

  };
}
