cask "ghosttype" do
  version "1.0.1"
  sha256 "f788ce5ae76f68ac35dabed90a105cefbc1581eabb95ff3a2125f82447b74195"

  url "https://github.com/bramlabs-io/ghosttype/releases/download/v#{version}/GhostType-#{version}.dmg"
  name "GhostType"
  desc "Copy and paste text anywhere - even where you can't"
  homepage "https://github.com/bramlabs-io/ghosttype"

  app "GhostType.app"

  zap trash: [
    "~/Library/Preferences/com.ghosttype.app.plist",
  ]
end
