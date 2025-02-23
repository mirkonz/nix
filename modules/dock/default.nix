{ config, pkgs, lib, ... }:

# Original source: https://gist.github.com/antifuchs/10138c4d838a63c0a05e725ccd7bccdd

with lib;
let
  cfg = config.local.dock;
  inherit (pkgs) stdenv dockutil;
in
{
  options = {
    local.dock.enable = mkOption {
      description = "Enable dock";
      default = stdenv.isDarwin;
      example = false;
    };

    local.dock.entries = mkOption
      {
        description = "Entries on the Dock";
        type = with types; listOf (submodule {
          options = {
            type = lib.mkOption {
              type = str;
              default = "app";
            };
            path = lib.mkOption {
              type = str;
              default = "";
            };
            view = lib.mkOption {
              type = str;
              default = "auto";
            };
            display = lib.mkOption {
              type = str;
              default = "folder";
            };
            section = lib.mkOption {
              type = str;
              default = "apps";
            };
            options = lib.mkOption {
              type = str;
              default = "";
            };
          };
        });
        readOnly = true;
      };
  };

  config =
    mkIf cfg.enable
      (
        let
          normalize = path: if hasSuffix ".app" path then path + "/" else path;
          entryURI = path: "file://" + (builtins.replaceStrings
            [" "   "!"   "\""  "#"   "$"   "%"   "&"   "'"   "("   ")"]
            ["%20" "%21" "%22" "%23" "%24" "%25" "%26" "%27" "%28" "%29"]
            (normalize path)
          );
          wantURIs = concatMapStrings
            (entry: "${entryURI entry.path}\n")
            cfg.entries;
          createEntries = concatMapStrings
            (entry:
              if hasSuffix "spacer" entry.type then
                "${dockutil}/bin/dockutil --no-restart --add '' --type ${entry.type} --section ${entry.section}\n"
              else if entry.type == "folder" then
                "${dockutil}/bin/dockutil --no-restart --add '${entry.path}' --view ${entry.view} --display ${entry.display}\n"
              else
                "${dockutil}/bin/dockutil --no-restart --add '${entry.path}' --section ${entry.section} ${entry.options}\n"
            ) cfg.entries;
        in
        {
          system.activationScripts.postUserActivation.text = ''
            echo >&2 "Setting up the Dock..."
            haveURIs="$(${dockutil}/bin/dockutil --list | ${pkgs.coreutils}/bin/cut -f2)"
            if ! diff -wu <(echo -n "$haveURIs") <(echo -n '${wantURIs}') >&2 ; then
              echo >&2 "Resetting Dock."
              ${dockutil}/bin/dockutil --no-restart --remove all
              ${createEntries}
              killall Dock
            else
              echo >&2 "Dock setup complete."
            fi
          '';
        }
      );
}