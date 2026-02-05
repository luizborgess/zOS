# vim: set ft=make :


# Install Flatpaks
install-flatpaks:
    #!/usr/bin/bash

    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/ublue-os/bazzite/main/installer/gnome_flatpaks/flatpaks | tr '\n' ' ')"
    flatpak --system -y install --reinstall --or-update ${FLATPAK_LIST}
