{
  pkgs,
  lib,
  username,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs; };
  safariWebAppCommands = lib.concatStringsSep "\n" (
    map (app: ''
      ~/Library/Mobile\ Documents/com~apple~CloudDocs/Scripts/create-safari-webapp.applescript "${app.url}" "${app.name}"
    '') packages.safariWebApps
  );
in
{
  # Home Manager settings
  home-manager.users.${username} =
    { pkgs, lib, ... }:
    {
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
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";

            l = "eza -bGF --header --git --color=always --group-directories-first --icons";
            ls = "eza --header --git --color=always --group-directories-first --icons";
            la = "eza --long --all --group --group-directories-first";
            ll = "eza -la --header --git --icons --octal-permissions --group-directories-first";

            t = "eza -Tl --icons";
            tree = "eza -T --icons";

            gra = "git rebase abort";

            grep = "rg";
            rm = "rm -i";
            cp = "cp -i";
            mv = "mv -i";

            vi = "nvim";
            vim = "nvim";
            _vim = "vi";

            cat = "bat";

            ytd = "yt-dlp";

            reload = "exec zsh; echo -e \"$(random_icon)  Done!\"";
            edit = "$EDITOR $HOME/nix";
            hosts = "sudo $EDITOR /etc/hosts";
            nixup = "nix run nix-darwin -- switch --flake .#mirko";
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
      # home.activation.createSafariWebApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
      #   ${safariWebAppCommands}
      # '';

    };
}
