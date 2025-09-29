#!/bin/bash
set -x
killall -9 -e artsd
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'scripterror' ERR
cd /workspace

echo "[Desktop Entry]" > '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Encoding=UTF-8" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Type=Application" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Exec=konsole -e bash -c \"cd /root/Desktop/v3.5\ Update\ Combo;  ./scripts/3.sh\"" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Terminal=false" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Name=v3.5 Update Combo" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Categories=Applocation" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
set +x
trap '' ERR
for ((i = 5; i > 0; i--)); do
echo -ne "Press any key in $i to abort automatic reboot... \r"
if read -rs -n 1 -t 1; then
echo -e "\nReboot aborted. "
sleep 1
if [ ! -f ~/.bashrc.bak ]; then
cp -f ~/.bashrc ~/.bashrc.bak
echo 'set -x' >> ~/.bashrc
echo 'set +e' >> ~/.bashrc
echo 'source pkgtool' >> ~/.bashrc
fi
sleep 1 && cp -f ~/.bashrc.bak ~/.bashrc && rm -f ~/.bashrc.bak &
exec bash -i
exit
fi
done
echo -e "\nRebooting now... "
sleep 1
reboot
