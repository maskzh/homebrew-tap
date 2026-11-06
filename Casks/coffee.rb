cask "coffee" do
  version "1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/maskzh/Coffee/releases/download/v#{version}/Coffee.zip"
  name "Coffee"
  desc "Minimal menu bar app to keep your Mac awake"
  homepage "https://github.com/maskzh/Coffee"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Coffee.app"

  # Not notarized: drop the quarantine flag so Gatekeeper doesn't block launch.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Coffee.app"]
  end

  uninstall quit: "com.maskzh.Coffee"

  zap trash: "~/Library/Preferences/com.maskzh.Coffee.plist"

  caveats <<~EOS
    "合盖时保持唤醒" requires a sudoers rule:
      echo "$(whoami) ALL=(root) NOPASSWD: /usr/bin/pmset -a disablesleep 0, /usr/bin/pmset -a disablesleep 1" | sudo tee /etc/sudoers.d/coffee
  EOS
end
