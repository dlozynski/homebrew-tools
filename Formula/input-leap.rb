class InputLeap < Formula
  desc "Open-source KVM software (formerly Barrier)"
  homepage "https://github.com/input-leap/input-leap"
  url "https://github.com/input-leap/input-leap.git", using: :git, revision: "0a72fdcfcf9d2cc0e03789fd74e48694132a003c"
  version "3.0.2-1+0a72fdc"
  license :cannot_represent

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on xcode: :build
  depends_on macos: :sierra
  depends_on "openssl"
  depends_on "qt"

  patch :DATA

  def install
    ENV["B_BUILD_TYPE"] = "Release"
    ENV["B_CMAKE_FLAGS"] = "-DINPUTLEAP_BUILD_TESTS=OFF"
    ENV["INPUTLEAP_BUILD_ENV"] = "1"
    system "cmake -S. -Bbuild"
    system "cmake --build build"
    system "codesign", "--deep", "--force", "--sign", "-", "build/bundle/InputLeap.app"
    prefix.install "build/bundle/InputLeap.app"
    system "cp -pR build/bundle/InputLeap.app /Applications/"
    bin.install_symlink prefix/"InputLeap.app/Contents/MacOS/input-leapc"
    bin.install_symlink prefix/"InputLeap.app/Contents/MacOS/input-leaps"
    man.mkpath
    man1.install "doc/input-leapc.1"
    man1.install "doc/input-leaps.1"
    doc.install Dir["doc/*"]
  end

  def caveats
    <<~EOS
      You will need to access the InputLeap.app directly from:
        #{opt_prefix}/InputLeap.app

      Run this at least once to properly register accessibility
      permissions before using the CLI tools.

      If your run into an accessibility permissions loop, try
      running:
        tccutil reset Accessibility input-leap

      This will reset your accessibility permissions; running the app
      again should then correctly grant it.

      The command-line binaries input-leapc (client) and input-leaps
      (server) have been linked and should be available from your
      PATH.

      Man pages have also been installed, and you will be able to find
      config file examples in:
        #{HOMEBREW_PREFIX}/share/doc/input-leap
    EOS
  end

  test do
    # Test not implemented for the time being as we're likely not
    # sending this to homebrew-core. Official formula will likely be
    # a cask, similar to Barrier.
    system "false"
  end
end
