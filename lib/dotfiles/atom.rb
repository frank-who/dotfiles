module Dotfiles
  class Atom

    def self.run
      message('Atom'.bold)
      system('killall Atom')

      update_icon
      symlink_atom
      symlink_apm

      packages
      system('open /Applications/Atom.app')
    end

    def self.update_icon
      app_icon = '/Applications/Atom.app/Contents/Resources/atom.icns'
      new_icon = "#{ROOT_PATH}/assets/atom.icns"

      FileUtils.rm(app_icon)
      FileUtils.cp(new_icon, app_icon)

      system('killall Dock')
      system('touch /Applications/Atom.app')

      message('Atom icon'.green, indent: 2)
    end

    private

      def self.packages
        message('Packages:'.bold, indent: 2)

        list = %w/
          aligner
          aligner-javascript
          aligner-ruby
          aligner-scss
          atom-beautify
          atom-clock
          atom-ctags
          color-picker
          dracula-syntax
          dracula-ui
          file-icons
          flex-tool-bar
          language-slim
          linter
          linter-codeclimate
          pigments
          preview
          rails-i18n-autocomplete
          sort-lines
          split-diff
          test-ruby
          title-case
          toggle-quotes
          tool-bar
          trailing-spaces
          tree-view-autoresize
        /

        list.each do |package|
          if !Dir.exist?("#{ENV['HOME']}/.atom/packages/#{package}")
            system("apm install #{package}")
          end
        end
      end

      def self.symlink_atom
        source = '/Applications/Atom.app/Contents/Resources/app/atom.sh'
        target = '/usr/local/bin/atom'
        if !File.exist?(source)
          FileUtils.ln_s(source, target)
        end
        message('symlink atom'.green, indent: 2)
      end

      def self.symlink_apm
        source = '/Applications/Atom.app/Contents/Resources/app/apm/node_modules/.bin/apm'
        target = '/usr/local/bin/apm'
        if !File.exist?(source)
          FileUtils.ln_s(source, target)
        end
        message('symlink apm'.green, indent: 2)
      end

  end
end
