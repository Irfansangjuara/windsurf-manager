cask "windsurf-manager" do
  version "4.1.32"
  sha256 :no_check

  name "Windsurf Manager"
  desc "Multi-account AI operations, proxy control, and routing manager"
  homepage "https://github.com/Irfansangjuara/windsurf-manager"

  on_macos do
    url "https://github.com/Irfansangjuara/windsurf-manager/releases/download/v#{version}/Windsurf.Manager_#{version}_universal.dmg"

    app "Windsurf Manager.app"

    zap trash: [
      "~/Library/Application Support/com.irfansangjuara.windsurf-manager",
      "~/Library/Caches/com.irfansangjuara.windsurf-manager",
      "~/Library/Preferences/com.irfansangjuara.windsurf-manager.plist",
      "~/Library/Saved Application State/com.irfansangjuara.windsurf-manager.savedState",
    ]

    caveats <<~EOS
      If you encounter the "App is damaged" error, please run the following command:
        sudo xattr -rd com.apple.quarantine "/Applications/Windsurf Manager.app"

      Or install with the --no-quarantine flag:
        brew install --cask --no-quarantine windsurf-manager
    EOS
  end

  on_linux do
    arch arm: "aarch64", intel: "amd64"

    url "https://github.com/Irfansangjuara/windsurf-manager/releases/download/v#{version}/Windsurf.Manager_#{version}_#{arch}.AppImage"
    binary "Windsurf.Manager_#{version}_#{arch}.AppImage", target: "windsurf-manager"

    preflight do
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/Windsurf.Manager_#{version}_#{arch}.AppImage"]
    end
  end
end
