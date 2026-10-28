# This file is written by the Guidelane Library release. Changes made here are replaced.
class GuidelaneLibrary < Formula
  desc "Server that keeps one shared Guidelane Studio library on your own network"
  homepage "https://github.com/guidelane-io/guidelane-library"
  version "0.1.0"
  # The binary is proprietary, under the Guidelane Library license in EULA.txt.
  license :cannot_represent

  on_macos do
    url "https://downloads.guidelane.io/library/0.1.0/guidelane-library-0.1.0-universal-apple-darwin.tar.gz"
    sha256 "700065a80dd59cc8217aad19268c671423bb5ac4e0010cc43e71f8a0a7dfd98c"
  end

  on_linux do
    on_intel do
      url "https://downloads.guidelane.io/library/0.1.0/guidelane-library-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6a5342291ec90d2a2834e8fec589fb9face13eda6e6684bf621dd94ac103d3d6"
    end
    on_arm do
      url "https://downloads.guidelane.io/library/0.1.0/guidelane-library-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9244b653356a18552ef251863b1b6e6776ff1f25a829a579785283183cf517bf"
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
