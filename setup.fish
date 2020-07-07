function install_fisher -d "installs jorgebucaran/fisher"
    echo "attempting to install jorgebucaran/fisher"
    if command curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
        echo "fisher installed successfully"
    else
        echo "fisher install failed"
    end
end

function install_plugins -d "installs fish plugins"
    set plugins -l Gazorby/fish-abbreviation-tips jorgebucaran/fish-bax franciscolourenco/done jorgebucaran/fish-spark joseluisq/gitnow@2.3.0 laughedelic/pisces jorgebucaran/fish-nvm jethrokuan/z

    echo "attempting to install fish plugins"
    for plugin in $plugins
        fisher add $plugin
    end
end

function install_kitty -d "installs kitty shell"
    echo "attempting to install kitty"
    if command curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
        echo "kitty installed successfully"
    else
        echo "kitty installation failed"
    end
end

function kitty_setup -d "kitty desktop integration"
    echo "setting up kitty shell"
    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
    # your PATH)
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
end

function kitty_conf -d "installs kitty conf"
    set -l dl_file "~/.config/kitty/kitty.conf"
    set -l url "https://gist.githubusercontent.com/g5becks/8cb4a040dbb10b516ba6b5eeaf2abbc5/raw/5c8ba08a625f7025487bed992228594d328f0ef6/kitty.conf"
    echo "attempting to download kitty conf"
    if command curl $url >$dl_file
        echo "kitty conf downloaded successfully"
    else
        "kitty conf download failed"
    end
end

function kitty_theme -d "sets kitty theme"
    set -l dl_file "~/.config/kitty/theme.conf"
    set -l url "https://gist.githubusercontent.com/g5becks/d7f0cae5643e5b8b4ea948bb8c640b96/raw/063f02eeff9f36e46ab68f39ba6c006ca1a97c43/theme.conf"
    echo "attempting to download kitty theme"
    if command curl $url >$dl_file
        echo "kitty theme installed"
    else
        echo "failed to install kitty theme"
    end
end

function download_hasklug -d "downloads hasklug_nerd_font"
    set -l url "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hasklig.zip"
    set -l dl_file "~/Downloads/hasklig.zip"
    echo "attempting to download hasklig nerd font"
    if command curl $url >$dl_file
        echo "hasklug_nerd_font downloaded successfully"
    else
        "hasklig download failed"
    end

end

function download_cartograph -d "downloads cartograph ch font"
    set -l url "http://download1074.mediafire.com/8tscikxkwasg/c4g1crf1d0hps9b/Cartograph.zip"
    set -l dl_file "~/Downloads/cartograph.zip"
    echo "attempting to download cartograph font"
    if command curl $url >$dl_file
        echo "cartograph font downloaded successfully"
    else
        echo "failed to download cartograph font"
    end
end

function unzip_fonts -d "unzip all font packages"
    set -l files ~/Downloads/cartograph.zip ~/Downloads/hasklig.zip
    echo "unzipping files"
    for font in $files
        if command unzip $font -d ~/Downloads/fonts
            echo "$font unzipped"
        else
            echo "failed to unzip $font"
        end
    end
end

function install_fonts -d "installs all downloaded fonts"
    set -l fonts ~/Downloads/fonts/*.otf
    set -l fonts_dir ~/.local/share/fonts/
    set -l trash ~/Downloads/fonts/ ~/Downloads/cartograph.zip ~/Downloads/hasklig.zip

    download_hasklug
    download_cartograph
    unzip_fonts
    if test -e $fonts_dir
        echo "moving fonts to fonts directory"
        command cp $fonts $fonts_dir
    else
        echo "no fonts directory found, creating now..."
        command mkdir -p $fonts_dir
        echo "moving fonts to fonts directory"
        command cp $fonts $fonts_dir
    end
    echo "clearing and regenerating font cache"
    if command fc-cache -f -v
        echo "fonts installed successfully"
        echo "cleaning up files"
        for $file in trash
            command rm -rf $file
        end
        echo "font installation complete"
    else
        echo "an issue occurred regenerating fonts cache"
    end
end

function install_snapd -d "installs snapd"
    echo "updating packages"
    command apt update
    echo "installing snapd"
    if command apt install snapd
        echo "snapd installed"
    else
        echo "failed to install snapd"
    end
end

function install_vscode -d "installs visual studio code"
    echo "installing visual studio code"
    if command sudo snap install code-insiders --classic
        echo "visual studio code installed"
    else
        echo "failed to install visual studio code"
    end
end

function install_android_studio -d "installs android studio"
    echo "installing android studio"
    if command snap install android-studio --classic
        echo "android studio installed"
    else
        "failed to install android studio"
    end
end

function install_remmina -d "installs remmina"
    echo "installing remmina"
    if command snap install remmina
        echo "remmina installed"
    else
        echo "failed to install remmina"
    end
end

function install_typora -d "installs typora"
    echo "installing typora"
    if command snap install typora-alanzanattadev
        echo "typora installed"
    else
        echo "failed to install typora"
    end
end

function install_insomnia -d "installs insomnia"
    echo "installing insomnia"
    if command snap install insomnia
        echo "insomnia installed"
    else
        echo "failed to install insomnia"
    end

end

function install_docker -d "installs docker"
    echo "installing docker"
    if command snap install docker
        echo "docker installed"
    else
        echo "failed to install docker"
    end
end

function install_table_plus -d "installs tableplus"
    # Add TablePlus gpg key
    echo "adding tableplus gpg key"
    if command wget -O - -q http://deb.tableplus.com/apt.tableplus.com.gpg.key | apt-key add -
        echo "gpg key added"
    else
        echo "failed to add gpg key"
    end
    # Add TablePlus repo
    echo "adding tableplus repo"
    command add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian tableplus main"

    echo "updating packages"
    command apt update
    echo "installing tableplus"
    if command apt install tableplus
        echo "tableplus installed"
    else
        "tableplus failed to install"
    end

end

function install_zeal -d "installs zeal"
    echo "adding zeal repo"
    command add-apt-repository ppa:zeal-developers/ppa
    echo "updating packages"
    command apt update
    echo "installing zeal"
    if command apt install zeal
        echo "zeal installed"
    else
        echo "failed to install zeal"
    end
end

function install_htop -d "installs htop"
    echo "installing htop"
    if command snap install htop
        echo "htop installed"
    else
        echo "failed to install htop"
    end
end

function install_fzf -d "install fzf"
    echo "installing fzf"
    if command apt install fzf
        echo "fzf installed"
    else
        echo "failed to install fzf"
    end
end

function install_starship -d "install starship prompt"

    echo "installing starship prompt"
    if command snap install starship
        echo "starship installed"
    else
        "failed to install starship"
    end
end

function starship_config -d "downloads starship config"
    set -l url "https://gist.githubusercontent.com/g5becks/27e40cf371c2e0afd859873a59632ff2/raw/15f128154ef5059bec5fdd47e5ff9632f673b9b5/starship.toml"
    echo "downloading starship config"

    set -l file "~/.config/starship.toml"

    if command curl $url >$file
        echo "starship config downloaded successfully"
    else
        echo "failed to download starship config"
    end
end

function install_digital_ocean_cli -d "installs digital ocean cli"
    echo "installing digital ocean cli"
    if command snap install doctl
        echo "digital ocean cli installed successfully"
    else
        echo "failed to install digital ocean cli"
    end
end

function install_postges -d "installs postgres"
    echo "installing postgres"
    if command snap install postgresql
        echo "postgres installed successfully"
    else
        "failed to install postgresql"
    end
end

function install_ruby -d "installs ruby"
    echo "installing ruby"
    if command snap install ruby --classic
        echo "ruby installed successfully"
    else
        echo "failed to install ruby"
    end
end
function install_colorls -d "installs colorls"
    echo "installing colorls"
    if command gem install colorls
        echo "colorls installed successfully"
    else
        echo "failed to install colorls"
    end
end

function install_go -d "installs golang"
    echo "installing golang"
    if command snap install --classic go
        echo "golang installed successfully"
    else
        echo "failed to install golang"
    end
end

function install_gotask -d "installs taskfile.dev"
    echo "installing taskfile.dev"
    if command snap install task --classic
        echo "taskfile.dev installed successfully"
    else
        echo "failed to install taskfile.dev"
    end
end

function install_dart -d "installs dart"
    echo "installing dart"
    command apt install apt-transport-https
    echo "obtaining gpg key"
    command sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    echo "adding dart repo"
    command sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
    echo "updating packages"
    command apt update
    echo "installing dart"
    if command apt install dart
        echo "dart installed successfully"
    else
        echo "failed to install dart"
    end
end

function install_flutter -d "installs flutter"
    echo "installing flutter"
    if command snap install flutter --classic
        echo "flutter installed successfully"
    else
        echo "failed to install flutter"
    end
end

function install_node -d "installs nodejs"
    echo "installing nodejs"
    if command snap install node --classic
        echo "nodejs installed successfully"
    else
        echo "failed to install nodejs"
    end
end

function install_firework -d "installs firework"
    set -l url "https://cdn-firework.com/fw/download/packages/Firework-linux-x64.zip"
    set -l dl_file "~/Downloads/firework.zip"
    echo "downloading firework"
    if command curl $url >$dl_file
        echo "firework downloaded successfully"
    else
        echo "failed to download firework, exiting function"
    end
end

function setup_machine -d "installs all apps and tools on a new machine"
    install_fisher
    install_plugins
    install_kitty
    kitty_setup
    kitty_conf
    kitty_theme
    install_fonts
    install_snapd
    install_android_studio
    install_vscode
    install_remmina
    install_typora
    install_insomnia
    install_docker
    install_table_plus
    install_zeal
    install_htop
    install_fzf
    install_starship
    starship_config
    install_digital_ocean_cli
    install_postges
    install_ruby
    install_colorls
    install_go
    install_gotask
    install_dart
    install_flutter
    install_node
    install_firework
end