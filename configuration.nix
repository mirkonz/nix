{ config, pkgs, self, username, homebrew-core, homebrew-cask, homebrew-bundle, mac-app-util, ... }:
{
  imports = [
    ./modules/dock
  ];

  nix = {
    enable = false;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;
    };
  };

  system.stateVersion = 6;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.activationScripts.safariDefaults.text = ''
    echo "Applying Safari settings..."
    /usr/bin/osascript -e '
    tell application "Safari"
      activate
      delay 2
      tell application "System Events"
        tell process "Safari"
          -- Enable Developer Menu
          set devMenuEnabled to (do shell script "defaults read com.apple.Safari IncludeDevelopMenu") as integer
          if devMenuEnabled is not 1 then
            do shell script "defaults write com.apple.Safari IncludeDevelopMenu -bool true"
          end if

          -- Enable Internal Debug Menu
          set debugMenuEnabled to (do shell script "defaults read com.apple.Safari IncludeInternalDebugMenu") as integer
          if debugMenuEnabled is not 1 then
            do shell script "defaults write com.apple.Safari IncludeInternalDebugMenu -bool true"
          end if

          -- Set Homepage
          do shell script "defaults write com.apple.Safari HomePage -string \"https://www.google.com\""

          -- Enable Extensions
          do shell script "defaults write com.apple.Safari ExtensionsEnabled -bool true"

          -- Set Default Browser Prompt State
          do shell script "defaults write com.apple.Safari DefaultBrowserPromptingState3 -int 4"

        end tell
      end tell
      quit
    end tell
    '
    echo "Safari settings applied!"
  '';

  system.defaults = {
    dock = {
      autohide = true; # Automatically hide and show the Dock
      autohide-delay = 0.0; # Remove the auto-hiding Dock delay
      autohide-time-modifier = 0.0; # Remove the auto-hiding Dock animation
      dashboard-in-overlay = true; # Don't show Dashboard as a Space
      expose-animation-duration = 0.001; # Remove the Expose animation
      expose-group-apps = false; # Don't group windows by application in Expose
      launchanim = false; # Remove the opening app animation
      mineffect = "scale"; # Set the minimize effect to Scale
      minimize-to-application = true; # Minimize windows into their application icon
      show-process-indicators = true; # Show indicator lights for open applications in the Dock
      show-recents = false; # Don't show recent applications in Dock
      tilesize = 36; # Set the icon size of Dock items to 36 pixels
    };

    finder = {
      FXDefaultSearchScope = "SCcf"; # Search the current folder by default
      FXEnableExtensionChangeWarning = false; # Disable the warning when changing a file extension
      FXPreferredViewStyle = "Nlsv"; # Use list view in all Finder windows by default
      FXRemoveOldTrashItems = true; # Empty Trash securely by default
      NewWindowTarget = "Home"; # Set "Home" as the default location for new Finder windows

      QuitMenuItem = true; # Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
      ShowPathbar = true; # Show path bar
      ShowStatusBar = true; # Show status bar
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # Use dark menu bar and Dock
      AppleShowScrollBars = "WhenScrolling"; # Automatically hide scrollbars in OS X
      ApplePressAndHoldEnabled = false; # Disable press-and-hold for keys in favor of key repeat
      NSNavPanelExpandedStateForSaveMode = true; # Expand save panel by default
      NSNavPanelExpandedStateForSaveMode2 = true; # Expand save panel by default
      PMPrintingExpandedStateForPrint = true; # Expand print panel by default
      PMPrintingExpandedStateForPrint2 = true; # Expand print panel by default
      NSAutomaticCapitalizationEnabled = false; # Disable automatic capitalization as it’s annoying when typing code
      NSAutomaticDashSubstitutionEnabled = false; # Disable smart dashes as they’re annoying when typing code
      NSAutomaticPeriodSubstitutionEnabled = false; # Disable automatic period substitution as it’s annoying when typing code
      NSAutomaticQuoteSubstitutionEnabled = false; # Disable smart quotes as they’re annoying when typing code
      NSAutomaticSpellingCorrectionEnabled = false; # Disable auto-correct
      NSAutomaticWindowAnimationsEnabled = false; # Disable window animations
      NSDocumentSaveNewDocumentsToCloud = false;
      NSTableViewDefaultSizeMode = 1; # Use small icons in icon view
      NSWindowResizeTime = 0.001; # Reduce window resize time
      KeyRepeat = 2; # Set a blazingly fast keyboard repeat rate
      InitialKeyRepeat = 15; # Set a blazingly fast keyboard repeat rate
      "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
      "com.apple.keyboard.fnState" = true; # fn for f1-12
    };
    CustomUserPreferences = {
      # "com.apple.Safari" = {
      #   ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled = true; # Add a context menu item for showing the Web Inspector in web views
      #   HomePage = "https://www.google.com";
      #   IncludeDevelopMenu = true;
      #   IncludeInternalDebugMenu = true;
      #   ExtensionsEnabled = true;
      #   DefaultBrowserPromptingState3 = 4;
      # };
      "com.apple.commerce" = {
        AutoUpdateRestartRequired = true; # Enable the Mac App Store to install system data files and security updates
        Autoupdate = true; # Enable the Mac App Store to install system data files and security updates
      };
      "com.apple.dashboard" = {
        mcx-disabled = true;
      };
      "com.apple.finder" = {
        DisableAllAnimations = true; # Disable animations when opening and closing windows
        FXInfoPanesExpanded = {
          General = true;
          OpenWith = true;
          Privileges = true;
          Metadata = true;
        }; # Open Info panes in all Finder windows by default
        QLEnableTextSelection = true; # Allow text selection in Quick Look
        QLEnableXRayFolders = true; # Allow Quick Look to display folder contents
        QLEnableXRayText = true; # Allow Quick Look to display text files
        QLEnableXRayImage = true; # Allow Quick Look to display image files
        QLEnableXRayPDF = true; # Allow Quick Look to display PDFs
        QLEnableXRayVideo = true; # Allow Quick Look to display video files
        QLEnableXRayAudio = true; # Allow Quick Look to display audio files
        QLEnableXRayArchive = true; # Allow Quick Look to display archive files
        QLEnableXRayCode = true; # Allow Quick Look to display code files
        QLEnableXRayMarkdown = true; # Allow Quick Look to display Markdown files
        QLEnableXRayJSON = true; # Allow Quick Look to display JSON files
        QLEnableXRayXML = true; # Allow Quick Look to display XML files
        QLEnableXRayWebArchive = true; # Allow Quick Look to display web archives
        QLEnableXRayFolder = true; # Allow Quick Look to display folder contents
        QLEnableXRayAlias = true; # Allow Quick Look to display alias contents
      };
    };

    # iterm2.PromptOnQuit = false; # Don't display the "Are you sure you want to quit?" dialog

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true; # Enable the automatic update check

    trackpad.Clicking = true; # Enable tap to click for this user and for the login screen

    menuExtraClock = {
      IsAnalog = true;
    };

    screencapture.location = "/Users/${username}/Downloads"; # Save screenshots to Downloads
    screencapture.disable-shadow = true; # Disable shadow in screenshots
  };

  # CLI tools
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      binutils
      coreutils
      diffutils
    ];
    pathsToLink = [ "/Applications" ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users."${username}" = import ./home.nix { inherit pkgs username mac-app-util; };
  };

  local = {
    dock = {
      enable = true;
      entries = [
        {path = "/System/Applications/Mail.app/";}
        {path = "/System/Applications/Calendar.app/";}
        {path = "/System/Applications/Reminders.app/";}
        {path = "/System/Applications/Notes.app/";}
        {type = "spacer";}
        # Web apps
        {path = "/Users/${username}/Applications/Home Manager Apps/Arc.app/";}
        {path = "/Users/${username}/Applications/Home Manager Apps/Spotify.app/";}
        {path = "/Applications/Plex.app/";}
        {type = "spacer";}
        # Development apps
        {path = "/Applications/iTerm.app/";}
        {path = "/Users/${username}/Applications/Home Manager Apps/Visual Studio Code.app/";}
        {path = "/Applications/Affinity Designer 2.app/";}
        {path = "/Applications/Affinity Photo 2.app/";}
        {type = "spacer";}
        # Communication apps
        {path = "/System/Applications/Messages.app/";}
        {path = "/Applications/WhatsApp.app/";}
        {path = "/System/Applications/FaceTime.app/";}
        {type = "spacer";}
        # System apps
        {path = "/System/Applications/App Store.app/";}
        {path = "/Applications/ChatGPT.app/";}
        {path = "/System/Applications/iPhone Mirroring.app/";}
        {path = "/System/Applications/System Settings.app/";}
        {type = "spacer";}
        # Utilities
        {
          path = "/Users/${username}/Applications/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          path = "/Applications/";
          section = "others";
          options = "--sort name --view list --display folder";
        }
        {
          path = "/Users/${username}/Downloads/";
          section = "others";
          options = "--sort dateadded --view list --display folder";
        }
      ];
    };
  };


  # Homebrew setup
  nix-homebrew = {
    enable = true;
    user = "${username}";

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # Disable this so that homebrew executables don't get on our PATH
    enableFishIntegration = false;
    enableBashIntegration = false;
    enableZshIntegration = false;

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;

    mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    caskArgs = {
      no_quarantine = true;
      require_sha = true;
    };
    casks = import ./cask-apps.nix;
    masApps = import ./mas-apps.nix;
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Set default shell
  users.users."${username}" = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
}

