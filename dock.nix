{
  imports = [
    ./modules/dock
  ];

  local.dock = {
    enable = true;
    entries = [
      { path = "/Applications/Commander One.app"; }
      { path = "/Applications/Spark.app"; }
      { path = "/System/Applications/Calendar.app"; }
      { path = "/System/Applications/Reminders.app"; }
      { path = "/System/Applications/Notes.app"; }
      { type = "spacer"; }
      { path = "/Applications/Microsoft Outlook.app"; }
      { path = "/Applications/Microsoft Teams.app"; }
      { path = "/Applications/Slack.app"; }
      { type = "spacer"; }
      { path = "/Applications/Arc.app"; }
      { type = "spacer"; }
      { path = "/Applications/Spotify.app"; }
      { path = "/Applications/Plex.app"; }
      { type = "spacer"; }
      { path = "/Applications/iTerm.app"; }
      { path = "/Applications/Visual Studio Code.app"; }
      { path = "/Applications/Affinity Designer 2.app"; }
      { path = "/Applications/Affinity Photo 2.app"; }
      { type = "spacer"; }
      { path = "/System/Applications/Messages.app"; }
      { path = "/Applications/WhatsApp.app"; }
      { path = "/System/Applications/FaceTime.app"; }
      { type = "spacer"; }
      { path = "/System/Applications/App Store.app"; }
      { path = "/Applications/ChatGPT.app"; }
      { path = "/System/Applications/iPhone Mirroring.app"; }
      { path = "/System/Applications/System Settings.app"; }
      { type = "spacer"; }
      # {
      #   path = "/Users/mirko/Applications/";
      #   section = "others";
      #   options = "--sort name --view grid --display folder";
      # }
      {
        path = "/Applications/";
        section = "others";
        options = "--sort name --view list --display folder";
      }
      {
        path = "/Users/mirko/Downloads/";
        section = "others";
        options = "--sort dateadded --view list --display folder";
      }
    ];
  };
}
