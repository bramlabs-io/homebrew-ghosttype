cask "ghosttype" do
  version "1.0.1"
  sha256 "8dbaa70b3e572a5fd92d0fd26846ab3d71ab931c74e2d1fdc7e5b84a0e4a9907"

  url "https://github.com/bramlabs-io/ghosttype/releases/download/v#{version}/GhostType-#{version}.dmg"
  name "GhostType"
  desc "Copy and paste text anywhere - even where you can't"
  homepage "https://github.com/bramlabs-io/ghosttype"

  app "GhostType.app"

  postflight do
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
