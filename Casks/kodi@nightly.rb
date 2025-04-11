cask "kodi@nightly" do
  arch arm: "arm64", intel: "x86_64"
  folder = on_arch_conditional arm: "arm64", intel: "x86_64"

  sha256 :no_check

  on_arm do
    version "20250411-4c3c11be,8264"
  end
  on_intel do
    version "20250411-4c3c11be,37987"
  end

  url "https://mirrors.kodi.tv/nightlies/osx/#{folder}/master/kodi-#{version.csv.first}-master-#{version.csv.second}-#{arch}.dmg"
  name "Kodi Nightly"
  desc "Free and open-source media player"
  homepage "https://kodi.tv/"

  # The regex below assumes that the release name will always be one word
  # (e.g., Leia, Matrix, Nexus, Omega, etc.).
  livecheck do
    url "https://mirrors.kodi.tv/nightlies/osx/#{arch}/master/"
    regex(/href=.*?kodi[._-](\d+[._-]\w+)[._-]master[._-](\d+)[._-]#{arch}\.dmg/i)
    strategy :page_match do |page, regex|
      match = page.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  depends_on macos: ">= :mojave"

  app "Kodi.app"

  # No trashing for user data for nightly builds
  # "~/Library/Application Support/Kodi",
  zap trash: [
    "~/.kodi",
    "~/Library/Logs/kodi.log",
    "~/Library/Logs/kodi.old.log",
    "~/Library/Preferences/org.xbmc.kodi.plist",
    "~/Library/Saved Application State/org.xbmc.kodi.savedState",
  ]
end
