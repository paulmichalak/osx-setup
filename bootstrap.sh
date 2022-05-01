#!/bin/sh
xcode-select --install
sudo xcodebuild -license

# Clone osxsetup
osxsetup="$HOME/src/osxsetup"
playbook="$osxsetup/playbook.yml"
mkdir -p "$osxsetup"
[ -e "$playbook" ] || git clone git@github.com:paulmichalak/osx-setup.git "$osxsetup"
cd "$osxsetup"

# Install homebrew
which brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Run ansible
brew install ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i "localhost," -c local "$playbook" --ask-become-pass