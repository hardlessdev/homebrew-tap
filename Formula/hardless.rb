class Hardless < Formula
  desc "The hardless binary: start the server, scan, tap, toggle faults, read receipts, run the MCP server."
  homepage "https://github.com/hardlessdev/hardless"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.0/hardless-cli-aarch64-apple-darwin.tar.gz"
      sha256 "8f7a1096a5be323e00279750f9b297024c469d03d9b3b4fd58e0d04b954db743"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.0/hardless-cli-x86_64-apple-darwin.tar.gz"
      sha256 "7f61e0152ec9afcc78be0eacb2086dd04ddfb0f98e5733d0f062f882c0bf6e69"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.0/hardless-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed3d93f4a9561321ed45713a603926553d2e4e19667b66755cbbaaef24350f87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardlessdev/hardless/releases/download/v0.1.0/hardless-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c03a9cc80bc28f964be0fc850cdd4f742f74c38089ce881d28851d1b55a1dc2a"
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
