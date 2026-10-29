# This file is written by the Guidelane Library release. Changes made here are replaced.
class GuidelaneLibrary < Formula
  desc "Server that keeps one shared Guidelane Studio library on your own network"
  homepage "https://github.com/guidelane-io/guidelane-library"
  version "0.1.1"
  # The binary is proprietary, under the Guidelane Library license in EULA.txt.
  license :cannot_represent

  on_macos do
    url "https://downloads.guidelane.io/library/0.1.1/guidelane-library-0.1.1-universal-apple-darwin.tar.gz"
    sha256 "8495a664d70f34554054ec087f9c6bd1b8a48a61977c7243fe40f52b5b7c913d"
  end

  on_linux do
    on_intel do
      url "https://downloads.guidelane.io/library/0.1.1/guidelane-library-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f856913945049be288309571df7b4fd0f9d14d9c1dfe6b4f0c17838963ae9b28"
    end
    on_arm do
      url "https://downloads.guidelane.io/library/0.1.1/guidelane-library-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7c961eb7dffc1267ba48452b90156e3791a49d82653c6e468668d83617eff5b4"
    end
  end

  def install
    bin.install "guidelane-library"
  end

  service do
    run [opt_bin/"guidelane-library", "--config", var/"guidelane-library/library.toml", "run", "--init", "--data", "."]
    keep_alive true
    log_path var/"log/guidelane-library.log"
    error_log_path var/"log/guidelane-library.log"
  end

  def caveats
    <<~EOS
      To start Guidelane Library now and each time this computer starts, run:
        sudo brew services start guidelane-library

      The server keeps its data in #{var}/guidelane-library. Its log, with the
      address of the admin page and its setup code, is #{var}/log/guidelane-library.log.
    EOS
  end

  test do
    assert_match "Usage: guidelane-library", shell_output("#{bin}/guidelane-library help")
  end
end
