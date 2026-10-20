class Pseudocopy < Formula
  desc "Copy every new file in a folder to the clipboard and reap old ones"
  homepage "https://github.com/BitPeppr/pseudocopy"
  url "https://github.com/BitPeppr/pseudocopy/releases/download/v1.0.0/pseudocopy-1.0.0-macos-universal.tar.gz"
  sha256 "4d9f223a6e12c7642bd6ddd9d2a45c85d4c8ff61d5ba81c9f412dab9c2d554b5"
  license "MIT"

  depends_on macos: :ventura

  def install
    bin.install "pseudocopy"
  end

  service do
    run [opt_bin/"pseudocopy", "run"]
    run_type :interval
    interval 5
    throttle_interval 5
    process_type :background
    log_path "#{Dir.home}/Library/Logs/pseudocopy.log"
    error_log_path "#{Dir.home}/Library/Logs/pseudocopy.log"
  end

  def caveats
    <<~EOS
      Start the watcher with:
        brew services start pseudocopy

      It copies every settled file in ~/Temp to the clipboard and moves files
      older than an hour to the Trash. Do not also run `pseudocopy install`:
      that would register a second agent.

      This service watches ~/Temp. To watch another folder, stop it and
      install the agent from a source checkout instead (see the README):
        brew services stop pseudocopy
    EOS
  end

  test do
    system bin/"pseudocopy", "gen-tests", testpath
    assert_path_exists testpath/"sample.txt"
    assert_match "pseudocopy #{version}", shell_output("#{bin}/pseudocopy version")
  end
end
