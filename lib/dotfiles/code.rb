module Dotfiles
  class Code

    def self.update_icon
      app_icon = '/Applications/Visual Studio Code.app/Contents/Resources/Code.icns'
      new_icon = "#{ROOT_PATH}/assets/code.icns"

      FileUtils.rm(app_icon)
      FileUtils.cp(new_icon, app_icon)

      system('killall Dock')
      system('touch /Applications/Visual\ Studio\ Code.app')

      message('Code icon'.green, indent: 2)
    end

  end
end
