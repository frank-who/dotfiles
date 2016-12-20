require File.expand_path('lib/macos_defaults', File.dirname(__FILE__))
require File.expand_path('lib/colorize_string', File.dirname(__FILE__))

task install: ['dotfiles:install']

namespace :dotfiles do

  task :install do
    puts "\n"
    system('sudo -v')

    system('chsh -s /bin/zsh')

    tasks = %w/symlinks macos_defaults/
    # tasks = %w/macos_defaults/
    tasks.each do |t|
      Rake::Task["dotfiles:#{t}"].invoke
      puts "\n"
    end
  end

  task :symlinks do
    message('Symlinks:'.bold, indent: 0)
    max_width = Dir['files/*.symlink'].map { |file| file_basename(file).length }.max

    Dir['files/*.symlink'].each do |file|
      create_symlink(file, max_width)
    end
  end

  task :macos_defaults do
    message('macOS Defaults:'.bold, indent: 0)

    system('chflags nohidden ~/Library')
    message('Always show ~/Library'.green, indent: 2)

    system('sudo systemsetup -setcomputersleep Off > /dev/null')
    message('Disable sleep'.green, indent: 2)

    system('sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true')
    message('Enable HiDPI resolution'.green, indent: 2)

    if RUBY_PLATFORM.include? 'darwin'
      all_defaults = {
        'Finder:' => {
          'com.apple.finder _FXShowPosixPathInTitle'         => '-bool true',
          'com.apple.finder _FXSortFoldersFirst'             => '-bool true',
          'com.apple.finder AppleShowAllFiles'               => '-bool true',
          'com.apple.finder CreateDesktop'                   => '-bool false',
          'com.apple.finder FXDefaultSearchScope'            => '-string "SCcf"',
          'com.apple.finder FXEnableExtensionChangeWarning'  => '-bool true',
          'com.apple.finder FXPreferredViewStyle'            => '-string "icnv"',
          'com.apple.finder NewWindowTarget'                 => '-string "PfDe"',
          'com.apple.finder NewWindowTargetPath'             => '-string "file://${HOME}/Desktop/"',
          'com.apple.finder ShowExternalHardDrivesOnDesktop' => '-bool true',
          'com.apple.finder ShowHardDrivesOnDesktop'         => '-bool true',
          'com.apple.finder ShowMountedServersOnDesktop'     => '-bool true',
          'com.apple.finder ShowPathbar'                     => '-bool true',
          'com.apple.finder ShowRemovableMediaOnDesktop'     => '-bool true',
          'com.apple.finder ShowStatusBar'                   => '-bool true',
          'com.apple.finder WarnOnEmptyTrash'                => '-bool false',
          'NSGlobalDomain AppleShowAllExtensions'            => '-bool true',
          'NSGlobalDomain com.apple.springing.delay'         => '-float 0',
          'NSGlobalDomain com.apple.springing.enabled'       => '-bool true'
        },
        'Dock:' => {
          'com.apple.dashboard mcx-disabled'                  => '-bool true',
          'com.apple.dock autohide-delay'                     => '-float 0',
          'com.apple.dock autohide'                           => '-bool true',
          'com.apple.dock expose-animation-duration'          => '-float 0.12',
          'com.apple.dock minimize-to-application'            => '-bool true',
          'com.apple.dock show-process-indicators'            => '-bool true',
          'com.apple.dock showhidden'                         => '-bool true',
          'com.apple.dock tilesize'                           => '-int 24',
          'com.apple.dock wvous-bl-corner'                    => '-int 5',
          'com.apple.dock wvous-bl-modifier'                  => '-int 0'
        },
        'Screen:' => {
          'com.apple.screensaver askForPassword'              => '-int 1',
          'com.apple.screensaver askForPasswordDelay'         => '-int 300',
          'com.apple.screencapture disable-shadow'            => '-bool true',
          'com.apple.screencapture type'                      => '-string "png"',
        },
        'Tweetbot:' => {
          'com.tapbots.TweetbotMac OpenURLsDirectly'          => '-bool true'
        },
        'Misc:' => {
          'com.apple.LaunchServices LSQuarantine'               => '-bool false',
          'NSGlobalDomain AppleFontSmoothing'                   => '-int 2',
          'NSGlobalDomain AppleKeyboardUIMode'                  => '-int 3',
          'NSGlobalDomain NSAutomaticDashSubstitutionEnabled'   => '-bool false',
          'NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled'  => '-bool false',
          'NSGlobalDomain NSAutomaticSpellingCorrectionEnabled' => '-bool false',
          'NSGlobalDomain NSNavPanelExpandedStateForSaveMode'   => '-bool true',
          'NSGlobalDomain NSTableViewDefaultSizeMode'           => '-int 1',
          'NSGlobalDomain NSUseAnimatedFocusRing'               => '-bool false'
        }
      }

      all_defaults.each do |group, defaults|
        message(group.bold, indent: 2)
        max_width = defaults.keys.map { |key| key.length }.max

        defaults.each do |key, value|
          system("defaults write #{key} #{value}")
          set_value = `defaults read #{key}`.strip.to_s.green

          message(("%-#{max_width}s => %s" % [key, set_value]), indent: 4)
        end
      end

      %w/Finder Dock Tweetbot SystemUIServer/.each do |app|
        system("killall #{app} &> /dev/null")
      end
    else
      message('Skipped'.red, indent: 2)
    end
  end

end

def create_symlink(file, max_width=0)
  basename = file_basename(file)
  source   = File.expand_path(file, File.dirname(__FILE__))
  target   = File.expand_path("~/#{file_basename(file).gsub('.symlink', '')}")

  if File.exist?(source)
    if File.symlink?(target)
      symlink_to = File.readlink(target)

      if symlink_to == source
        message_part = "[Skipped] #{target} exists".red
      else
        message_part = "[Re-created] #{target}".green

        FileUtils.rm(target)
        FileUtils.ln_s(source, target)
      end
    elsif File.exist?(target)
      backup       = "#{target}_backup.#{Date.today.strftime('%Y%m%d%H%M%S')}"
      message_part = "[Overwritten] #{target}".red

      FileUtils.mv(target, backup)
      FileUtils.ln_s(source, target)
    else
      message_part = "[Created] #{target}".green

      FileUtils.ln_s(source, target)
    end
  else
    message_part = "[Source Missing] #{source}".red
  end

  message(("%-#{max_width}s => %s" % [basename, message_part]), indent: 2)
end
