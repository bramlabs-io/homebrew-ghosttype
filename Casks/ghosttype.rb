cask "ghosttype" do
  version "1.0.5"
  sha256 "cd9d3ece92a06c8ddf50d4ee6d1b56e4764b87c3a45b17f60d101cf732dd83d2"

  url "https://github.com/bramlabs-io/ghosttype/releases/download/v#{version}/GhostType-#{version}.dmg"
  name "GhostType"
  desc "Copy and paste text anywhere - even where you can't"
  homepage "https://github.com/bramlabs-io/ghosttype"

  # Quit app before upgrade/uninstall
  uninstall quit: "com.ghosttype.app"

  app "GhostType.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "/Applications/GhostType.app"]
    system_command "/usr/bin/osascript", args: [
      "-e", 'tell application "System Events" to make login item at end with properties {path:"/Applications/GhostType.app", hidden:false}'
    ]
    system_command "/usr/bin/open", args: ["/Applications/GhostType.app"]
  end

  uninstall_postflight do
    system_command "/usr/bin/osascript", args: [
      "-e", 'tell application "System Events" to delete login item "GhostType"'
    ], must_succeed: false
  end

  zap trash: [
    "~/Library/Preferences/com.ghosttype.app.plist",
  ]
end
