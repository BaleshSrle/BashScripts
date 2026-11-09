#!/bin/bash

APPS=("chrome" "filezilla" "firefox-bin" "hypnotix" "msedge" "opera" "spotify" "vivaldi-bin")
BROWSERS=("google-chrome" "microsoft-edge" "mozilla/firefox" "opera/Default" "vivaldi")
IMG_EXT=("png" "jpg")
THUMBNAIL_SIZE=("normal" "large" "xx-large")
CACHE_DIR="$HOME/.cache"
draw_line() {
    printf '%*s\n' "$(tput cols)" '' | tr ' ' '='
    #printf '%*s\n' 60 '' | tr ' ' '='
}


echo Clear Package Cache
sudo apt autoclean ; sudo apt clean ; sudo apt autopurge ; sudo apt autoremove
draw_line
echo Closing The Opened Apps
for APP in "${APPS[@]}"; do
    if pgrep -x "$APP" > /dev/null
    then
        echo "[*] $APP is being shutted dowm..."
        pkill -x "$APP"
    else
        echo "[ ] $APP is not even opened."
    fi
done
draw_line
echo Clear Web Browser Cache
#rm -rf ~/.cache/"${BROWSERS[@]}"/*
for browser in "${BROWSERS[@]}"; do
    if [[ -d "$CACHE_DIR/$browser" ]]; then
        echo "[*] Cache in the $browser is being deleted..."
        rm -rf "${CACHE_DIR:?}/${browser:?}"/*
#    else
#        echo "[ ] Cache in the $browser is not being deleted"
    fi
done
draw_line
echo Clear Filezilla Cache
rm -rf "$CACHE_DIR/filezilla"/*
draw_line
echo Clear Hypnotix Image Cache
#rm -v ~/.cache/hypnotix/providers/*."${IMG_EXT[@]}" 2>/dev/null
for imgext in "${IMG_EXT[@]}"; do
    rm -v "${CACHE_DIR:?}/hypnotix/providers/"*."${imgext:?}" 2>/dev/null
done
draw_line
echo Delete Spotify Cache
rm -rf "${CACHE_DIR:?}/spotify"/*
draw_line
echo Clear RClone Image Cache
rm -v "${CACHE_DIR:?}/rclone/webgui/current/build/static/media"/*.svg 2>/dev/null
draw_line
echo Clear MintInstall Screenshot Cache
rm -v "${CACHE_DIR:?}/mintinstall/screenshots"/*.png 2>/dev/null
draw_line
echo Clear Thumbnail Image Cache
#rm -v ~/.cache/thumbnails/"${THUMBNAIL_SIZE[@]}"/*.png 2>/dev/null
for size in "${THUMBNAIL_SIZE[@]}"; do
    rm -v "${CACHE_DIR:?}/thumbnails/${size:?}"/*.png 2>/dev/null    
done
draw_line
echo Clear Sessions Image Cache
rm -v "${CACHE_DIR:?}/sessions/thumbs-$(hostname)":*/*.png 2>/dev/null
draw_line
echo Flush DNS Cache
#sudo dhclient -r && sudo dhclient
sudo resolvectl flush-caches

