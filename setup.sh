#
# Personal
#

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/subhrashisdas/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off

# Install iterm2
brew install --cask iterm2

# Install Curl
brew install curl

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Brave Browser
brew install --cask brave-browser

# Install Google Chrome
brew install --cask google-chrome

# Install Visual Studio Code
brew install --cask visual-studio-code

# Install rancher
brew install --cask rancher

# Install Dockutil
brew install dockutil
dockutil --remove all

defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 36

killall Dock

#
# Manual Task
#

# Install Bitwarden
open https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb

#
# Work
#

# Install Deno
brew install deno

# Install NodeJS
brew install node

# Install Slack
brew install --cask slack

# Install Notion
brew install --cask notion

# Install Zoom
brew install --cask zoom

# Add applications to the Dock
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Rancher\ Desktop.app
dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/Brave\ Browser.app
dockutil --add /Applications/Notion.app
dockutil --add /Applications/Slack.app

defaults write com.apple.dock tilesize -int 40
killall Dock
