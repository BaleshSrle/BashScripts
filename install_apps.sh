#!/bin/bash

draw_line() {
    printf '%*s\n' "$(tput cols)" '' | tr ' ' '='
}
ARCH="$(dpkg --print-architecture)"
EXT=("deb" "sh" "tar.gz")

cd /tmp || exit

# if command -v wget &> /dev/null; then
#	DL_TOOL="wget -P ./ --https-only -4 --no-cache --no-cookies"
# fi

# shellcheck disable=SC1091

if [ -f /etc/os-release ]; then
	. /etc/os-release
fi

draw_line
echo -e "		Application Installer for $PRETTY_NAME $DESKTOP_SESSION		"
draw_line
echo "Select applications that you want to download and install:"
# Define all 50 options in an array
options=(
    "1) Bitwarden Desktop App"
    "2) Discord"
    "3) Signal"
    "4) Slack"
    "5) Telegram Desktop"
    "6) Viber for Desktop"
    "7) Webex"
    "8) Zoom Workplace"
    "9) Google Chrome"
    "10) Microsoft Edge"
    "11) Opera"
    "12) Vivaldi"
    "13) Visual Studio Code"
    "14) HeidiSQL"
    "15) SoapUI"
    "16) Katalon Studio"
    "17) Postman"
    "18) OBS Studio"
    "19) Git"
    "20) GitKraken Desktop"
    "21) AnyDesk"
    "22) TeamViewer"
    "23) MEGA Desktop App"
    "24) MEGA File Manager integration"
    "25) Rclone"
    "26) ghostwriter"
    "27) Simplenote"
    "28) Wordpress Desktop App"
    "29) LibreOffice"
    "30) WPS Office"
    "31) LocalSend"
    "32) ChatGPT Desktop App"
    "33) Codex CLI"
    "34) Claude Desktop"
    "35) Claude CLI"
    "36) GitHub Copilot App"
    "37) GitHub Copilot CLI"
    "38) OpenCode Desktop App"
    "39) OpenCode CLI"
    "40) Perplexity CLI"
    "41) draw.io Desktop App"
    "42) FileZilla"
    "43) KDE Connect"
    "44) OpenJDK 17 JRE"
    "45) Python3 Selenium"
    "46) Microsoft TrueType Font install"
    "47) Whois"
    "48) Enable NumLock"
    "49) Netload plugin for Xfce4"
    "50) WaveLAN plugin for Xfce4"
    "51) Wireshark"
    "52) OpenSC"
    "53) Node.js"
    "54) Node.js util module"
    "55) Emote"
    "56) Spotify"
    "57) Balena Etcher"
    "58) Steam"
    "59) Check and update APT and Flatpak"
    "60) Cleanup"
    "61) Reboot"
    "62) EXIT"
)

# Set your fixed column width here (adjust as needed)
col_width=28

total=${#options[@]}
rows=$(( (total + 2) / 3 ))

# Process row by row
for ((i=0; i<rows; i++)); do
    item1="${options[i]:-}"
    item2="${options[i + rows]:-}"
    item3="${options[i + rows * 2]:-}"

    # Wrap each item to the fixed column width using 'fold' (-s wraps on spaces)
    mapfile -t lines1 < <(echo "$item1" | fold -s -w "$col_width")
    mapfile -t lines2 < <(echo "$item2" | fold -s -w "$col_width")
    mapfile -t lines3 < <(echo "$item3" | fold -s -w "$col_width")

    # Find the maximum number of lines required for this specific row
    max_lines=${#lines1[@]}
    (( ${#lines2[@]} > max_lines )) && max_lines=${#lines2[@]}
    (( ${#lines3[@]} > max_lines )) && max_lines=${#lines3[@]}

    # Print line-by-line so wrapped text aligns properly
    for ((l=0; l<max_lines; l++)); do
        l1="${lines1[l]:-}"
        l2="${lines2[l]:-}"
        l3="${lines3[l]:-}"

        printf "%-*s  %-*s  %-s\n" "$col_width" "$l1" "$col_width" "$l2" "$l3"
    done
done
draw_line
read -rp "Enter your choice [1-62]: " choice
case $choice in
    1) URL="https://github.com/bitwarden/clients/releases/download/desktop-v2026.10.4/Bitwarden-2026.10.4-${ARCH}.deb" FILENAME="Bitwarden-*-${ARCH}.deb" ;;
    2) URL="https://stable.dl2.discordapp.net/distro/app/stable/linux/x64/1.0.168/Discord.deb" FILENAME="Discord.deb" ;;
    3)
	    curl https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
		# cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
		# sudo install -m 644 signal-desktop-keyring.gpg /usr/share/keyrings/signal-desktop-keyring.gpg
		echo signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null ; curl -o signal-dektop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources
		# cat signal.desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
		# sudo install -m 644 signal.desktop.sources /etc/apt/sources.list.d/signal-desktop.sources
		echo signal.desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null ; sudo apt update && sudo apt install signal-desktop ;;
    4) URL="https://downloads.slack-edge.com/desktop-releases/linux/x64/4.53.276/slack-desktop-4.53.276-${ARCH}.deb" FILENAME="slack-desktop-*-${ARCH}.deb" ;;
    5) FLATPAK_APP="org.telegram.desktop" ;;
    6) URL="https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb" FILENAME="viber.deb" ;;
    7) URL="https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb" FILENAME="Webex.deb" ;;
    8) URL="https://cdn.zoom.us/prod/7.2.5.6661/zoom_${ARCH}.deb" FILENAME="zoom_${ARCH}.deb" ;;
    9) URL="https://dl.google.com/linux/direct/google-chrome-stable_current_${ARCH}.deb" FILENAME="google-chrome-stable_current_${ARCH}.deb" ;;
    10) URL="https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_157.0.4341.42-1_${ARCH}.deb" FILENAME="microsoft-edge-stable_*-1_${ARCH}.deb" ;;
    11) URL="https://get.opera.com/ftp/pub/opera/desktop/139.0.6053.22/linux/opera-stable_139.0.6053.22_${ARCH}.deb" FILENAME="opera-stable_*_${ARCH}.deb" ;;
    12) URL="https://downloads.vivaldi.com/stable/vivaldi-stable_8.3.4191.30-1_${ARCH}.deb" FILENAME="vivaldi-stable_*-1_${ARCH}.deb" ;;
    13) URL="https://vscode.download.prss.microsoft.com/dbazure/download/stable/c4453f8ea430795f941c1b2ff6c9321135a74a02/code_1.145.2-1793945276_${ARCH}.deb" FILENAME="code_*-*_${ARCH}.deb" ;;
    14) URL="https://github.com/HeidiSQL/HeidiSQL/releases/latest/download/heidisql_12.22_${ARCH}.deb" FILENAME="heidisql_*_${ARCH}.deb" ;;
    15) wget ./ --https-only -4 --no-cache --no-cookies "https://dl.eviware.com/soapuios/5.10.0/SoapUI-x64-5.10.0.sh" ; chmod +x ./SoapUI-x64-*.sh ; sh ./SoapUI-x64-*.sh ;;
    16) wget -P ./ --https-only -4 --no-cache --no-cookies "https://github.com/katalon-studio/katalon-studio/releases/download/free-v9.7.6/Katalon_Studio_Free_Linux_64-9.7.6.tar.gz" ; tar -xf Katalon_Studio_Free_Linux_64-*.tar.gz -C ~/ ; sudo mv ~/Katalon_Studio_Free_Linux_64-9.7.6 ~/KatalonStudio ;;
    17) wget -P ./ --https-only -4 --no-cache --no-cookies "https://dl.pstmn.io/download/latest/linux_64" -O postman.tar.gz ; tar zxf postman.tar.gz -C ~/ ;;
    18) PPA="obsproject/obs-studio" PPA_PACKAGE="obs-studio" ;;
    19) PPA="git-core/ppa" PPA_PACKAGE="git" ;;
    20) URL="https://release.gitkraken.dev/gkd/production/normal/linux/x64/12.6.1/3KuKzJPRRWs4JUuNtKUApKDrOtD/gitkraken-${ARCH}.deb" FILENAME="gitkraken-${ARCH}.deb" ;;
    21) sudo apt update ; sudo apt install ca-certificates curl apt-transport-https ; sudo install -m 0755 -d /etc/apt/keyrings ; sudo curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY -o /etc/apt/keyrings/keys.anydesk.com.asc ; sudo chmod a+r /etc/apt/keyrings/keys.anydesk.com.asc ; echo "deb [signed-by=/etc/apt/keyrings/keys.anydesk.com.asc] https://deb.anydesk.com all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null ; sudo apt update ; sudo apt install anydesk ;;
    22) URL="https://download.teamviewer.com/download/linux/teamviewer_${ARCH}.deb" FILENAME="teamviewer_${ARCH}.deb" ;;
    23) URL="https://mega.nz/linux/repo/xUbuntu_24.04/${ARCH}/megasync-xUbuntu_24.04_${ARCH}.deb" FILENAME="megasync-xUbuntu_*_${ARCH}.deb" ;;
    24) URL="https://mega.nz/linux/repo/xUbuntu_24.04/${ARCH}/thunar-megasync-xUbuntu_24.04_${ARCH}.deb" FILENAME="thunar-megasync-xUbuntu_*_${ARCH}.deb" ;;
    25) sudo -v ; curl https://rclone.org/install.sh | sudo bash ;;
    26) PACKAGE="ghostwriter" ;;
    27) URL="https://github.com/Automattic/simplenote-electron/releases/latest/download/Simplenote-linux-2.27.1-${ARCH}.deb" FILENAME="Simplenote-linux-*-${ARCH}.deb" ;;
    28) URL="https://github.com/Automattic/wp-desktop/releases/latest/download/wordpress.com-linux-deb-8.2.4.deb" FILENAME="wordpress.com-linux-deb-*.deb" ;;
    29) wget -P ./ --https-only -4 --no-cache --no-cookies "https://download.documentfoundation.org/libreoffice/stable/26.8.1/deb/x86_64/LibreOffice_26.8.1_Linux_x86-64_deb.tar.gz" ; wget -P ./ --https-only -4 --no-cache --no-cookies "https://download.documentfoundation.org/libreoffice/stable/26.8.1/deb/x86_64/LibreOffice_26.8.1_Linux_x86-64_deb_langpack_sr.tar.gz" ; tar zxvf ./LibreOffice_*_Linux_x86-64_deb.tar.gz ; tar zxvf ./LibreOffice_*_Linux_x86-64_deb_langpack_*.tar.gz ; mv LibreOffice_*_Linux_x86-64_deb_langpack_*/DEBS/*deb LibreOffice_*_Linux_x86-64_Deb/DEBS/ ; sudo dpkg -i ./LibreOffice_*_Linux_x86-64_deb/DEBS/*.deb ; rm -r ./LibreOffice_*_Linux_x86-64_deb_langpack_* ; rm -r ./LibreOffice_*_Linux_x86-64_deb ;;
    30) URL="https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/wps-office.deb" FILENAME="wps-office.deb" ;;
    31) URL="https://github.com/localsend/localsend/releases/latest/download/LocalSend-1.18.2-linux-x86-64.deb" FILENAME="LocalSend-*-linux-x86-64.deb" ;;
    32) URL="https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_${ARCH}.deb" FILENAME="chatgpt_${ARCH}.deb" ;;
    33) curl -fsSL https://chatgpt.com/codex/install.sh | sh ;;
    34) curl -fLO "https://downloads.claude.ai/claude-desktop/apt/stable/$(curl -s "https://downloads.claude.ai/claude-desktop/apt/stable/dists/stable/main/binary-${ARCH}/Packages" | grep '^Filename: pool/main/c/claude-desktop/claude-desktop_' | sort -V | tail -n 1 | cut -d' ' -f2)" ; sudo apt install ./claude-desktop_*.deb ;;
    35) curl -fsSL https://claude.ai/install.sh | bash ;;
    36) URL="https://github.com/github/app/releases/latest/download/GitHub-Copilot-linux-x64.deb" FILENAME="GitHub-Copilot-linux-x64.deb" ;;
    37) curl -fsSL https://gh.io/copilot-install | bash ;;
    38) URL="https://opencode.ai/update/api/latest/desktop/opencode/opencode-desktop-linux-${ARCH}.deb" FILENAME="opencode-desktop-linux-${ARCH}.deb" ;;
    39) curl -fsSL https://opencode.ai/v2/install | bash ;;
    40) curl -fsSL https://github.com/perplexityai/perplexity-cli/releases/latest/download/install.sh | sh ;;
    41) URL="https://github.com/jgraph/drawio-desktop/releases/latest/download/drawio-${ARCH}-32.6.10.deb" FILENAME="drawio-${ARCH}-*.deb" ;;
	42) PACKAGE="filezilla" ;;
    43) PACKAGE="kdeconnect" ;;
    44) PACKAGE="openjdk-17-jre" ;;
    45) PACKAGE="python3-selenium" ;;
    46) PACKAGE="ttf-mscorefonts-installer" ;;
    47) PACKAGE="whois" ;;
    48) PACKAGE="numlockx" ;;
    49) PACKAGE="xfce4-netload-plugin" ;;
    50) PACKAGE="xfce4-wavelan-plugin" ;;
    51) PPA="wireshark-dev/stable" PPA_PACKAGE="wireshark" ;;
    52) PACKAGE="opensc" ;;
    53) PACKAGE="nodejs" ;;
    54) PACKAGE="node-util" ;;
	55)	FLATPAK_APP="com.tomjwatson.Emote" ;;
	56) curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg ; echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list ; sudo apt update && sudo apt install spotify-client ;;
	57) URL="https://github.com/balena-io/etcher/releases/latest/download/balena-etcher_${ARCH}_amd64.deb" FILENAME="balena-etcher_*_${ARCH}.deb" ;;
    58) URL="https://cdn.fastly.steamstatic.com/client/installer/steam.deb" FILENAME="steam.deb" ;;
    59) sudo apt update ; sudo apt upgrade ; flatpak update ;;
	60)
		sudo apt autoclean ; sudo apt autopurge ; sudo apt autoremove
		for ext in "${EXT[@]}"; do
			rm -v "./"*."$ext" 2>/dev/null
		done
		;;
	61) sudo systemctl reboot ;;
    62) 
        # exit
        kill -9 $PPID
        ;;
#    *) 
#       echo "Error: Invalid choice or not a direct download item."
#       exit 1 
#        ;;
esac

if [ -n "$URL" ]; then
   # "$DL_TOOL" "$URL" && sudo apt install "./$FILENAME"
    # shellcheck disable=SC2086
    wget -P ./ --https-only -4 --no-cache --no-cookies "$URL" ; sudo apt install ./$FILENAME
elif [ -n "$PACKAGE" ]; then
	sudo apt install "$PACKAGE"
elif [ -n "$FLATPAK_APP" ]; then
	flatpak install flathub "$FLATPAK_APP"
elif [ -n "$PPA" ]; then
	sudo add-apt-repository "ppa:$PPA" ; sudo apt update ; sudo apt install "$PPA_PACKAGE"
fi 