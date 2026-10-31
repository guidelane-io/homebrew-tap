# This file is written by the Guidelane Library release. Changes made here are replaced.
class GuidelaneLibrary < Formula
  desc "Server that keeps one shared Guidelane Studio library on your own network"
  homepage "https://github.com/guidelane-io/guidelane-library"
  version "1.0.1"
  # The binary is proprietary, under the Guidelane Library license in EULA.txt.
  license :cannot_represent

  on_macos do
    url "https://downloads.guidelane.io/library/1.0.1/guidelane-library-1.0.1-universal-apple-darwin.tar.gz"
    sha256 "d6af17d65e6dfc69896631ed5f7e1cbf6aa0be2639b3e6b3240f3f23b2cf8d32"
  end

  on_linux do
    on_intel do
      url "https://downloads.guidelane.io/library/1.0.1/guidelane-library-1.0.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "18e8c37e4c884373c203b0af27ab3c2d99ca3c4dff4ba1ba30defd3fe116624a"
    end
    on_arm do
      url "https://downloads.guidelane.io/library/1.0.1/guidelane-library-1.0.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1bcf26919706268eed96a1328e80c579795e9dfcba9be4f2c9fbd52d17705cdb"
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
