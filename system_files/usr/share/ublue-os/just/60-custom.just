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

# Setup cloudflare dns
setup-cloudflare-dns:
    #!/usr/bin/bash
    echo " Iniciando configuração do DNS Cloudflare..."

    # 1. Detecta o nome da conexão ativa (a que tem a rota padrão)
    CON_NAME=$(nmcli -t -f NAME,DEVICE connection show --active | head -n 1 | cut -d: -f1)

    if [ -z "$CON_NAME" ]; then
        echo " Erro: Nenhuma conexão ativa encontrada!"
        exit 1
    fi

    echo " Conexão detectada: $CON_NAME"

    # 2. Aplica DNS IPv4 (Cloudflare) e ignora o automático da operadora
    echo "Configurando IPv4..."
    nmcli connection modify "$CON_NAME" ipv4.dns "1.1.1.1 1.0.0.1"

    # 3. Aplica DNS IPv6 (Cloudflare) e ignora o automático da operadora
    echo "Configurando IPv6..."
    nmcli connection modify "$CON_NAME" ipv6.dns "2606:4700:4700::1111 2606:4700:4700::1001"
    nmcli connection modify "$CON_NAME" ipv6.ignore-auto-dns yes

    # 4. Reinicia a conexão para aplicar as mudanças
    echo "Reiniciando a conexão..."
    nmcli connection up "$CON_NAME"

    # 5. Limpa o cache do systemd-resolved para garantir
    echo "Limpando cache de DNS..."
    resolvectl flush-caches

    echo "Pronto! DNS da Cloudflare aplicado com sucesso."