class RustSrc < Formula
  desc "The Rust sources"
  homepage "https://www.rust-lang.org/downloads.html"
  url "https://static.rust-lang.org/dist/rustc-1.3.0-src.tar.gz"
  sha256 "ea02d7bc9e7de5b8be3fe6b37ea9b2bd823f9a532c8e4c47d02f37f24ffa3126"
  version "1.3.0"

  depends_on "rust"

  cxxstdlib_check :skip             # To ignore debug `.elf` and `.macho` files

  def install
    system "cp", "-a", "src/", "#{prefix}/src"

    plist_path.write <<-PLIST.undent
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
                "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>Label</key>
        <string>setenv.RUST_SRC_PATH</string>
        <key>ProgramArguments</key>
        <array>
          <string>/bin/launchctl</string>
          <string>setenv</string>
          <string>RUST_SRC_PATH</string>
          <string>#{prefix}/src</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
      </plist>
    PLIST
    plist_path.chmod 0644
  end

  def caveats
    <<-EOS.undent
      The launchctl plist is used to put the RUST_SRC_PATH environment
      variable in scope.
    EOS
  end
end
