class Albafetch < Formula
  desc "Faster neofetch alternative, written in C. Still improving :)"
  homepage "https://github.com/alba4k/albafetch/"
  version "4.2.1"
  url "https://github.com/alba4k/albafetch/archive/refs/tags/v#{version}.tar.gz"
  sha256 "9c691e245a0f4ad11eba82852d4f55eaeacfebef260c029145bea64581f911df"

  license "MIT"
  head "https://github.com/alba4k/albafetch.git", branch: "master"

  livecheck do
    url :stable
    regex(/[^"' >]*?v?(\d+(?:\.\d+)+)[^"' >]*?/i)
    strategy :github_latest
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_equal "albafetch - a system fetch utility (#{version})", pipe_output("#{bin}/albafetch -h | grep #{version}")
  end
end
