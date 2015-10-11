class Racer < Formula
  desc "Installs RACER, the Rust Auto-Complete-er"
  homepage "https://github.com/phildawes/racer"
  head "https://github.com/phildawes/racer.git", :using => :git

  depends_on "rust"

  def install
    ENV["PATH"] = "/usr/local/bin:#{ENV["PATH"]}"
    system %q(cargo build --release)
    bin.install "target/release/racer"
  end
end
