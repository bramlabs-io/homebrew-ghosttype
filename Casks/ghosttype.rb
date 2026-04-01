cask "ghosttype" do
  version "1.0.4"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  url "https://github.com/bramlabs-io/ghosttype/releases/download/v#{version}/GhostType-#{version}.dmg"
  name "GhostType"
  desc "Copy and paste text anywhere - even where you can't"
  homepage "https://github.com/bramlabs-io/ghosttype"

  # Quit app before upgrade/uninstall
  uninstall quit: "com.ghosttype.app"

  app "GhostType.app"

  postflight do
    # Clear stale accessibility permissions from previous installs
    system_command "/usr/bin/tccutil", args: ["reset", "Accessibility", "com.ghosttype.app"], must_succeed: false
    system_command "/usr/bin/xattr", args: ["-cr", "/Applications/GhostType.app"]
    system_command "/usr/bin/osascript", args: [
      "-e", 'tell application "System Events" to make login item at end with properties {path:"/Applications/GhostType.app", hidden:false}'
    ]
    system_command "/usr/bin/open", args: ["/Applications/GhostType.app"]
  end

  uninstall_preflight do
    # Reset accessibility permissions on uninstall
    system_command "/usr/bin/tccutil", args: ["reset", "Accessibility", "com.ghosttype.app"], must_succeed: false
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
