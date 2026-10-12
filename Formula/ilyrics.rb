class Ilyrics < Formula
  desc "Lyrics videos of the iPhone Music Lyrics screen, with on-device synchronization"
  homepage "https://github.com/x96x64/ilyrics"
  url "https://github.com/x96x64/ilyrics/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "152f56d85485e874b612ea9041dd19304462137533619b69031fa68b620b9577"
  license "Apache-2.0"
  head "https://github.com/x96x64/ilyrics.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "ilyrics"
    bin.install ".build/release/ilyrics"
    (share/"ilyrics").install "share/ilyrics/templates"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ilyrics --version")
    assert_match "share/ilyrics/templates", shell_output("#{bin}/ilyrics models status")
  end
end
