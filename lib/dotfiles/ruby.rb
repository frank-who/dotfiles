module Dotfiles
  class Ruby

    def self.run
      message('Ruby:'.bold)
      rbenv
      ruby_build
    end

    private

      def self.rbenv
        if File.exist?(File.join(ENV['HOME'], '.rbenv'))
          message('rbenv'.green, indent: 2)
        else
          message('rbenv'.red, indent: 2)
          system('git clone git://github.com/rbenv/rbenv.git ~/.rbenv')
        end
      end

      def self.ruby_build
        if File.exist?(File.join(ENV['HOME'], '.rbenv/plugins/ruby-build'))
          message('ruby-build'.green, indent: 2)
        else
          message('ruby-build'.red, indent: 2)
          system('git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build')
        end
      end

  end
end
