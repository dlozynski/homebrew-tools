cask "kodi@nightly" do

  version "master"
  sha256 :no_check
  arch arm: "arm64", intel: "x86_64"

  @@os="osx"
  @@extension="dmg"
  @@build_number="00000"
  # Update those values
  @@date="20250325"
  @@revision="71734296"

  on_macos do
    @@extension="dmg"
    @os="osx"
    if Hardware::CPU.arm?
      # Update this value
      @@build_number="8126"
    end
    if Hardware::CPU.intel?
      # Update this value
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
    regex(/href=.*?kodi[._-](\d+)[._-](\d+)[._-]master[._-](\d+)[._-]x86_64\.dmg/i)
  end

  depends_on macos: ">= :mojave"

  app "Kodi.app"

  # No trashing for user data for nightly builds
  #"~/Library/Application Support/Kodi",  
  zap trash: [
    "~/.kodi",
    "~/Library/Logs/kodi.log",
    "~/Library/Logs/kodi.old.log",
    "~/Library/Preferences/org.xbmc.kodi.plist",
    "~/Library/Saved Application State/org.xbmc.kodi.savedState",
  ]
end
