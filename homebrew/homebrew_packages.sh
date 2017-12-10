# Emacs Setup
brew tap d12frosted/emacs-plus
brew install emacs-plus
brew linkapps emacs-plus
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
npm install -g git://github.com/adobe-fonts/source-code-pro.git#release
cd ~/node_modules/source-code-pro  && ./build.sh

# Ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
