cask "ghosttype" do
  version "1.0.1"
  sha256 "633607a5c9120df3a845b2b770eae09b4411453aac4157d93c8f3c81ac4ccc27"

  url "https://github.com/bramlabs-io/ghosttype/releases/download/v#{version}/GhostType-#{version}.dmg"
  name "GhostType"
  desc "Copy and paste text anywhere - even where you can't"
  homepage "https://github.com/bramlabs-io/ghosttype"

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
