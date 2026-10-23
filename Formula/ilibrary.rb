# Generated for x96x64/homebrew-tap from the verified release source archive.
class Ilibrary < Formula
  desc "Catalog-driven music tagging and ordered import into Apple Music"
  homepage "https://github.com/x96x64/ilibrary"
  url "https://github.com/x96x64/ilibrary/releases/download/v1.0.3/ilibrary-1.0.3-source.tar.gz"
  version "1.0.3"
  sha256 "0f2a01ddc369cb9ee2900a7d54af517a6db5e90063e33640ba349be68ce42a0b"
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
