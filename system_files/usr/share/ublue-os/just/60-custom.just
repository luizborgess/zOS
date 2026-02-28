# vim: set ft=make :


# Install Flatpaks
install-flatpaks:
    #!/usr/bin/bash

    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/luizborgess/zOS/main/installer/flatpaks | tr '\n' ' ')"
    flatpak --system -y install --reinstall --or-update ${FLATPAK_LIST}

# Setup quality of life
setup-qof:
    #!/usr/bin/bash
    groupadd docker
    sudo usermod -aG docker $USER