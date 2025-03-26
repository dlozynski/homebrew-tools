cask "deskflow" do
  arch arm: "AppleSilicon", intel: "x86_64"

  version "1.20.1"
  sha256 :no_check

  url "https://github.com/deskflow/deskflow/releases/download/v#{version}/deskflow-#{version}-macos-#{arch}.dmg"
  name "Deskflow"
  desc "Deskflow lets you share one mouse and keyboard between multiple computers on Windows, macOS and Linux. It's like a software KVM (but without video). Sponsored by Synergy."
  homepage "https://github.com/deskflow/deskflow"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  depends_on macos: ">= :catalina"

  app "Deskflow.app"

  zap trash: [
    "~/Library/Deskflow",
    "~/Library/Preferences/org.deskflow.Deskflow.plist",
    "~/Library/Saved Application State/org.deskflow.savedState",
  ]

end
