# Sketch http://bohemiancoding.com/sketch/support/documentation/13-preferences/
defaults write com.bohemiancoding.sketch3 exportCompactSVG -bool yes


# No autohide delay on Dock
defaults write com.apple.Dock autohide-delay -bool no

# Make Dock in Mavericks transparent
defaults write com.apple.dock hide-mirror -bool yes

# Don't save to iCloud by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool no
