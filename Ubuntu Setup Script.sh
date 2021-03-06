#!/bin/bash
# Start of Function Cluster
mainmenu () {
	clear
 	tput setaf 3
	echo "=================================="
	echo " --- Ubuntu Setup Script 3.22 ---"
	echo "=================================="
	echo "Supported Ubuntu Versions: 20.04 LTS, 20.10"
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to see packages to be installed in detail."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	echo "It is not recommended to run this script more than once!!!"
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	echo "Press 3 to perform a Debloat"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection followed by <return>:"
	read answer
	case "$answer" in
		1) fullmenu;;
		2) minimalmenu;;
		3) debloatconfirm;;
		q) quitscript;;
		Q) quitscript;;
	esac
	badoption
}
fullmenu () {
    clear
 	tput setaf 3
	echo "=============================="
	echo " --- Full Install Options ---"
	echo "=============================="
	echo "Press 1 to select the configuration for Ubuntu. This applies to the primary edition of Ubuntu only. Please do not use this on the official Ubuntu flavors or derivatives."
	echo "Press 2 to select the universal configuration for Ubuntu-based distros. This includes official Ubuntu flavors and derivatives. This option is not guaranteed to always work although it has been designed to try to work on as many configurations of Ubuntu-based distros as possible."
	tput setaf 9
	echo "Press Q to return to Main Menu"
	tput sgr0
	echo "Enter your selection followed by <return>:"
	read answer
	case "$answer" in
		1) full;;
		2) fulluniversal;;
		q) mainmenu;;
		Q) mainmenu;;
	esac
	badoptionfull
}
minimalmenu () {
	clear
 	tput setaf 3
	echo "================================="
	echo " --- Minimal Install Options ---"
	echo "================================="
	echo "Press 1 to select the configuration for Ubuntu. This applies to the primary edition of Ubuntu only. Please do not use this on the official Ubuntu flavors or derivatives."
	echo "Press 2 to select the universal configuration for Ubuntu-based distros. This includes official Ubuntu flavors and derivatives. This option is not guaranteed to always work although it has been designed to try to work on as many configurations of Ubuntu-based distros as possible."
	tput setaf 9
	echo "Press Q to return to Main Menu"
	tput sgr0
	echo "Enter your selection followed by <return>:"
	read answer
	case "$answer" in
		1) minimal;;
		2) minimaluniversal;;
		q) mainmenu;;
		Q) mainmenu;;
	esac
	badoptionminimal
}
debloatconfirm () {
	clear
 	tput setaf 3
	echo "=============================="
	echo " --- Debloat Confirmation ---"
	echo "=============================="
	echo "This will remove all Ubuntu customizations to GNOME and revert to Vanilla GNOME."
	echo "After this operation, you may still need to tweak the system to Vanilla GNOME or your personal preference. Also, you will have to select GNOME on Xorg when you login if you want to use Xorg as this script resets that setting."
	tput setaf 9
	echo "Some operations performed in this script are irreversible!!!"
	tput sgr0
	echo "Are you sure you want to continue? [y/N]"
	echo "Enter your selection followed by <return>:"
	read answer
	case "$answer" in
		y) debloat;;
		Y) debloat;;
	esac
	mainmenu
}
quitscript () {
	tput sgr0
	clear
	exit
}
badoption () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Main Menu..."
	tput sgr0
	sleep 3
	mainmenu
}
badoptionfull () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Full Install Options..."
	tput sgr0
	sleep 3
	fullmenu
}
badoptionminimal () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Minimal Install Options..."
	tput sgr0
	sleep 3
	minimalmenu
}
finish () {
	clear
	tput setaf 10
	echo "Done..."
	tput setaf 9
	echo "Rebooting..."
	tput sgr0
	sleep 3
	clear
	sudo reboot
}
full () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages (Main Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
	sudo apt install -y ubuntu-restricted-extras gnome-backgrounds ubuntu-gnome-wallpapers synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gnome-boxes gparted vlc p7zip-full p7zip-rar gnome-tweaks lame gpart grub2-common neofetch network-manager-openvpn-gnome ffmpeg httraqt lsp-plugins tree audacity telegram-desktop gufw easytag android-tools-adb android-tools-fastboot gnome-sound-recorder cheese nikwi supertux dconf-editor deja-dup gnome-todo pitivi gnome-sushi unoconv ffmpegthumbs fonts-cantarell gnome-books krita gnome-clocks gimp htop transmission curl git handbrake gnome-shell-extension-prefs gdebi gnome-weather gnome-firmware gucharmap menulibre minetest gtk-3-examples nautilus-admin python3-pip
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo add-apt-repository -y ppa:linuxuprising/java
	sudo apt install -y oracle-java15-installer
	java --version
	sleep 3
	java -version
	sleep 3
	sudo add-apt-repository -y ppa:mkusb/ppa
	sudo apt install -y mkusb mkusb-nox usb-pack-efi gparted
	sudo add-apt-repository -y ppa:obsproject/obs-studio
	sudo apt install -y obs-studio
	sudo add-apt-repository ppa:nextcloud-devs/client
	sudo apt install nextcloud-client
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	pip3 install youtube-dl
	echo "Adding current user to cdrom group..."
	sudo usermod -aG cdrom $USER
	gio mime text/calendar org.gnome.Calendar.desktop
	echo "Patching LSP icons..."
	mkdir ~/.local/share/applications
	echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	finish
}
minimal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials (Main Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
	sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gnome-tweaks gpart network-manager-openvpn-gnome ffmpeg gufw dconf-editor deja-dup gnome-sushi unoconv ffmpegthumbs fonts-cantarell htop curl git gnome-shell-extension-prefs gdebi gnome-firmware gucharmap menulibre gtk-3-examples nautilus-admin
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	gio mime text/calendar org.gnome.Calendar.desktop
	finish
}
fulluniversal () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages (Universal Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
	sudo apt install -y ubuntu-restricted-extras gnome-backgrounds ubuntu-gnome-wallpapers synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gnome-boxes gparted vlc p7zip-full p7zip-rar lame gpart grub2-common neofetch network-manager-openvpn-gnome ffmpeg httraqt lsp-plugins tree audacity telegram-desktop gufw easytag android-tools-adb android-tools-fastboot gnome-sound-recorder cheese nikwi supertux dconf-editor deja-dup gnome-todo pitivi ffmpegthumbs fonts-cantarell gnome-books krita gnome-clocks gimp htop transmission curl git handbrake gdebi gnome-weather gnome-firmware gucharmap menulibre minetest gtk-3-examples python3-pip
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo add-apt-repository -y ppa:linuxuprising/java
	sudo apt install -y oracle-java15-installer
	java --version
	sleep 3
	java -version
	sleep 3
	sudo add-apt-repository -y ppa:mkusb/ppa
	sudo apt install -y mkusb mkusb-nox usb-pack-efi gparted
	sudo add-apt-repository -y ppa:obsproject/obs-studio
	sudo apt install -y obs-studio
	sudo add-apt-repository ppa:nextcloud-devs/client
	sudo apt install nextcloud-client
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	pip3 install youtube-dl
	echo "Adding current user to cdrom group..."
	sudo usermod -aG cdrom $USER
	gio mime text/calendar org.gnome.Calendar.desktop
	echo "Patching LSP icons..."
	mkdir ~/.local/share/applications
	echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	finish
}
minimaluniversal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials (Universal Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
	sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gpart network-manager-openvpn-gnome ffmpeg gufw dconf-editor deja-dup ffmpegthumbs fonts-cantarell htop curl git gdebi gnome-firmware gucharmap menulibre gtk-3-examples
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	gio mime text/calendar org.gnome.Calendar.desktop
	finish
}
debloat () {
	clear
	tput setaf 3
	echo "Debloating..."
	tput sgr0
	sleep 3
	clear
	sudo apt-mark manual shotwell remmina
	sudo apt update -y
	sudo apt install -y gnome-session vanilla-gnome-desktop vanilla-gnome-default-settings  gnome-backgrounds
	sudo rm /usr/share/plymouth/ubuntu-logo.png
	sudo apt purge -y ubuntu-desktop ubuntu-session gnome-shell-extension-desktop-icons gnome-shell-extension-ubuntu-dock yaru*
	sudo apt autoremove -y --purge
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
	gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
	finish
}
# End of Function Cluster
# Start of Main Script
while true
do
	mainmenu
done
# End of Main Script
