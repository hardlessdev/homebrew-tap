class Hardless < Formula
  desc "The hardless binary: start the server, scan, tap, toggle faults, read receipts, run the MCP server."
  homepage "https://github.com/hardlessdev/hardless"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.1/hardless-cli-aarch64-apple-darwin.tar.gz"
      sha256 "131a106bda4ce80dd448785547711527fee5873a18e91da07ba0666184d89802"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.1/hardless-cli-x86_64-apple-darwin.tar.gz"
      sha256 "e18712a32a284b780b963fb3c71d6de55e6ef8352eec9571826001b3452e36d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.1/hardless-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "153da15ec29f301a51dfe30c7a6fb7e115ddd837944819647810593dcb52ec92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.1/hardless-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d2a36e9ab5fa384134a385c524d903c2be69fa8317987a6a0fc422c9a1a31cb"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hardless"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hardless"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hardless"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hardless"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
