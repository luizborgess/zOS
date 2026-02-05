# vim: set ft=make :


# Install Flatpaks
install-flatpaks:
    #!/usr/bin/bash

    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/luizborgess/zOS/main/installer/flatpaks | tr '\n' ' ')"
    flatpak --system -y install --reinstall --or-update ${FLATPAK_LIST}
