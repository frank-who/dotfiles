module Dotfiles
  class Zsh

    def self.run
      message('Shell:'.bold)

      if ENV['SHELL'].match(/zsh/)
        message('zsh'.green, indent: 2)
      else
        message('zsh'.red, indent: 2)
        system('chsh -s `which zsh`')
      end
    end

  end
end
