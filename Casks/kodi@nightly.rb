cask "kodi@nightly" do

  version "master"
  date "20250325"
  commit "71734296"


  sha256 :no_check

  arch arm: "arm64", intel: "x86_64"
  build_number arm: "8126", intel: "37850"

  url "https://mirrors.kodi.tv/nightlies/osx/#{arch}/#{version}/kodi-#{date}-#{commit}-#{version}-#{build_number}-#{arch}.dmg"
  name "Kodi Nightly"
  desc "Free and open-source media player"
  homepage "https://kodi.tv/"

  # The regex below assumes that the release name will always be one word
  # (e.g., Leia, Matrix, Nexus, Omega, etc.).
  livecheck do
    url "https://mirrors.kodi.tv/nightlies/osx/#{arch}/#{version}/"
    regex(/href=.*?kodi[._-]\d+?[._-]\d+?-#{version}[._-]\d+?-#{arch}\.dmg/i)
  end

  depends_on macos: ">= :mojave"

  app "Kodi.app"

  zap trash: [
    "~/.kodi",
    "~/Library/Application Support/Kodi",
    "~/Library/Logs/kodi.log",
    "~/Library/Logs/kodi.old.log",
    "~/Library/Preferences/org.xbmc.kodi.plist",
    "~/Library/Saved Application State/org.xbmc.kodi.savedState",
  ]
end
