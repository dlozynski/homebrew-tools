cask "kodi@nightly" do

  version "master"
  sha256 :no_check
  arch arm: "arm64", intel: "x86_64"

  @@revision="71734296"
  @@date="20250325"
  @@os="osx"
  @@build_number="00000"
  @@extension="dmg"

  on_macos do
    @@extension="dmg"
    @os="osx"
    if Hardware::CPU.arm?
      @@build_number="8126"
    end
    if Hardware::CPU.intel?
      @@build_number="37850"
    end
  end

  url "https://mirrors.kodi.tv/nightlies/osx/#{arch}/#{version}/kodi-#{@@date}-#{@@revision}-#{version}-#{@@build_number}-#{arch}.#{@@extension}"
  
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
