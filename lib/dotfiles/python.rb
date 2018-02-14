module Dotfiles
  class Python

    def self.run
      message('Python:'.bold)
      pyenv
    end

    private

      def self.pyenv
        if File.exist?(File.join(ENV['HOME'], '.pyenv'))
          message('pyenv'.green, indent: 2)
        else
          message('pyenv'.red, indent: 2)
          system('git clone https://github.com/pyenv/pyenv.git ~/.pyenv')
        end
      end

  end
end
