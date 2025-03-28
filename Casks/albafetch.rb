cask "albafetch" do
  arch arm: "AppleSilicon", intel: "x64"

  version "4.2.1"
  sha256 "14abee10b1d8fac9f1f0cf499b96f6eed8f031e699874c91957a331bd47deb09"

  url "https://github.com/alba4k/albafetch/releases/download/v#{version}/albafetch-darwin-#{arch}.zip"
  name "albafetch"
  desc "Faster neofetch alternative, written in C. Still improving :)"
  homepage "https://github.com/alba4k/albafetch/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  binary "albafetch"

  postflight do
    set_permissions "#{staged_path}/albafetch", "0755"
  end

  zap trash: "~/Library/Application Support/albafetch"
end
