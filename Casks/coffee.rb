cask "coffee" do
  version "1.2"
  sha256 "60f8161562d23fd2b56d49af5a202afa97b291df32284aef5150be1f23468116"

  url "https://github.com/maskzh/Coffee/releases/download/v#{version}/Coffee.zip"
  name "Coffee"
  desc "Minimal menu bar app that prevents sleep"
  homepage "https://github.com/maskzh/Coffee"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Coffee.app"

  # Not notarized: drop the quarantine flag so Gatekeeper doesn't block launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Coffee.app"]
  end

  uninstall quit: "com.maskzh.Coffee"

  zap trash: "~/Library/Preferences/com.maskzh.Coffee.plist"

  caveats <<~EOS
    "合盖时保持唤醒" requires a sudoers rule:
      echo "$(whoami) ALL=(root) NOPASSWD: /usr/bin/pmset -a disablesleep 0, /usr/bin/pmset -a disablesleep 1" | sudo tee /etc/sudoers.d/coffee
  EOS
end
