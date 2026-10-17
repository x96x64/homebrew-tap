# Generated for x96x64/homebrew-tap from the verified release source archive.
class Ilibrary < Formula
  desc "Catalog-driven music tagging and ordered import into Apple Music"
  homepage "https://github.com/x96x64/ilibrary"
  url "https://github.com/x96x64/ilibrary/releases/download/v0.1.0/ilibrary-0.1.0-source.tar.gz"
  version "0.1.0"
  sha256 "7bf0b4a4af208c9ac0941f5bc46c97f78e8af6ff6a56532e83f6fbaef5c68368"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    swift = Utils.safe_popen_read("swift", "--version")[/Swift version (\d+)/, 1].to_i
    odie "iLibrary requires Swift 6 or later from Xcode or the Command Line Tools" if swift < 6
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "ilibrary"
    bin.install ".build/release/ilibrary"
  end

  test do
    assert_equal "ilibrary #{version}\n", shell_output("#{bin}/ilibrary --version")
    assert_match "ilibrary-catalog-1", shell_output("#{bin}/ilibrary schema")
    assert_match "--dry-run", shell_output("#{bin}/ilibrary help apply")
  end
end
