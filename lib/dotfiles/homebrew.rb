module Dotfiles
  class Homebrew

    def self.run
      message('Homebrew'.bold)
      system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      system('brew update')
      system('brew bundle')
    end

  end
end
