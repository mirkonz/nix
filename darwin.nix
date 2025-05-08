{
  config,
  inputs,
  pkgs,
  self,
  username,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  nix = {
    enable = false;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Ensure nix-darwin can find the right platform
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  # Enable nix-homebrew
  nix-homebrew = {
    enable = true;
    user = username;
    enableRosetta = true;
    autoMigrate = true;
    mutableTaps = false;
    enableZshIntegration = true;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
  };

  # Declarative Homebrew package management
  homebrew = {
    enable = true;
    brews = packages.homebrewPackages;
    casks = packages.homebrewCaskPackages;
    masApps = packages.masPackages;
  };

  # Set default system path
  environment.pathsToLink = [ "/Applications" ];

  # Zsh as default shell
  environment.shells = [ pkgs.zsh ];

  # System-level packages
  environment.systemPackages = packages.systemPackages;

  # System state version
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
