#!/bin/bash
# Start of Function Cluster
checkcompatibility () {
	# Set variables
	. /etc/os-release
	isubuntu="false"
	kernelarch=$(uname -m)
	
	# Check distro
	if ! grep -qi "ubuntu" /etc/os-release
	then
		sysreqfail
	fi
	isubuntu="true"
	
	# Function cluster for identifying codenames
	case "$UBUNTU_CODENAME" in
		"xenial") ubuntuverno="16.04 LTS";;
		"bionic") ubuntuverno="18.04 LTS";;
		"focal") ubuntuverno="20.04 LTS";;
		"groovy") ubuntuverno="20.10";;
		"hirsute") ubuntuverno="21.04";;
		*) ubuntuverno="UNDEFINED, Contact maintainer";;
	esac
	# End cluster
	
	# Check for 20.04 and 21.04
	if ! grep -qie "focal" -e "hirsute" /etc/os-release
	then
		sysreqfail
	fi
	
	# Check kernel architecture
	if ! uname -m | grep -qi "x86_64"
	then
		sysreqfail
	fi
	
	# Check if Pop!_OS
	if lsb_release -d | grep -qi '^Description:[[:space:]]*Pop!_OS *[0-9][0-9]*\.'
	then
		usededicatedscript
	fi
}
sysreqfail () {
	clear
	tput setaf 9
	echo "System requirements not met. This script supports x86_64 versions of Ubuntu and Ubuntu-based distros with versions being based on 20.04 LTS (focal) and 21.04 (hirsute)!!!"
	tput setaf 3
	echo "If your error is not caused by a wrong Ubuntu version or OS architecture, please check to see if I have published a script for your system."
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Is Ubuntu-based: $isubuntu"
	# Display Ubuntu codename if distro is Ubuntu-based
	if grep -qi "ubuntu" /etc/os-release
	then
		echo "Your current Ubuntu version is $ubuntuverno (Codename: $UBUNTU_CODENAME)."
	fi
	echo "Your current OS architecture is $kernelarch."
	tput sgr0
	echo "Hit any key to exit:"
	IFS=""
	read -sN1 answer
	quitscript
}
usededicatedscript () {
	clear
	tput setaf 3
	echo "While your distro is x86_64 Ubuntu-based and is a supported version, there is already a script specific to your system. Please use that script instead."
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Your current OS architecture is $kernelarch."
	tput sgr0
	echo "Hit any key to exit:"
	IFS=""
	read -sN1 answer
	quitscript
}
checkcompatibility40 () {
	if ! grep -qi "hirsute" /etc/os-release
	then
		sysreqfail40
	elif ! dpkg -l gnome-shell | grep -qi ^i
	then
		sysreqfail40
	fi
}
sysreqfail40 () {
	clear
	tput setaf 9
	echo "We have noticed that you are likely not using standard Ubuntu or GNOME on version 21.04. This option only works with standard Ubuntu or GNOME on version 21.04."
	tput sgr0
	echo "Hit any key to return to Main Menu:"
	IFS=""
	read -sN1 answer
	mainmenu
}
checkcompatibilitygnome () {
	if ! dpkg -l gnome-shell | grep -qi ^i
	then
		sysreqfailgnome
	fi
}
sysreqfailgnome () {
	clear
	tput setaf 9
	echo "We have noticed that you are likely not using standard Ubuntu or GNOME. Please choose the correct script version suitable for your system." 
	tput setaf 3
	echo "Try the Universal option."
	tput sgr0
	echo "Hit any key to return to Main Menu:"
	IFS=""
	read -sN1 answer
	mainmenu
}
checkcompatibilitygnomeinv () {
	if dpkg -l gnome-shell | grep -qi ^i
	then
		sysreqfailgnomeinv
	fi
}
sysreqfailgnomeinv () {
	clear
	tput setaf 9
	echo "We have noticed that you are likely using standard Ubuntu or an Ubuntu-based distro with GNOME. Please choose the correct script version suitable for your system." 
	tput setaf 3
	echo "Try the Standard Ubuntu/GNOME option."
	tput sgr0
	echo "Hit any key to return to Main Menu:"
	IFS=""
	read -sN1 answer
	mainmenu
}
mainmenu () {
	clear
 	tput setaf 3
	echo "================================="
	echo " --- Ubuntu Setup Script 4.0 ---"
	echo "================================="
	echo "Supported Ubuntu Versions (x86_64): 20.04 LTS, 21.04"
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Is Ubuntu-based: $isubuntu"
	echo "Your current Ubuntu version is $ubuntuverno (Codename: $UBUNTU_CODENAME)."
	echo "Your current OS architecture is $kernelarch."
	tput setaf 3
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to see packages to be installed in detail."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	echo "It is not recommended to run this script more than once unless after a distro upgrade!!!"
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	echo "Press 3 to perform a Debloat (GNOME only) (Standard Ubuntu recommended)"
	echo "Press 4 to perform an upgrade to GNOME 40 (21.04 only) (GNOME only) (Standard Ubuntu recommended) (Debloat also performed)"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	fullmenu;;
		2)	minimalmenu;;
		3)	debloatconfirm;;
		4)	upgradetognome40confirm;;
		q)	quitscript;;
		*)	badoption;;
	esac
}
fullmenu () {
    clear
 	tput setaf 3
	echo "=============================="
	echo " --- Full Install Options ---"
	echo "=============================="
	echo "Press 1 to select the configuration for standard Ubuntu or GNOME. This applies to the primary edition of Ubuntu only. Please do not use this on the official Ubuntu flavors or derivatives."
	echo "Press 2 to select the universal configuration for Ubuntu-based distros. This includes official Ubuntu flavors and derivatives that don't use GNOME. This option is not guaranteed to always work although it has been designed to try to work on as many configurations of Ubuntu-based distros as possible."
	tput setaf 9
	echo "Press Q to return to Main Menu"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	full;;
		2)	fulluniversal;;
		q)	mainmenu;;
		*)	badoptionfull;;
	esac
}
minimalmenu () {
	clear
 	tput setaf 3
	echo "================================="
	echo " --- Minimal Install Options ---"
	echo "================================="
	echo "Press 1 to select the configuration for standard Ubuntu or GNOME. This applies to the primary edition of Ubuntu only. Please do not use this on the official Ubuntu flavors or derivatives."
	echo "Press 2 to select the universal configuration for Ubuntu-based distros. This includes official Ubuntu flavors and derivatives that don't use GNOME. This option is not guaranteed to always work although it has been designed to try to work on as many configurations of Ubuntu-based distros as possible."
	tput setaf 9
	echo "Press Q to return to Main Menu"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	minimal;;
		2)	minimaluniversal;;
		q)	mainmenu;;
		*)	badoptionminimal;;
	esac
}
debloatconfirm () {
	checkcompatibilitygnome2
	clear
 	tput setaf 3
	echo "=============================="
	echo " --- Debloat Confirmation ---"
	echo "=============================="
	echo "This will remove all Ubuntu customizations to GNOME and revert to Vanilla GNOME."
	echo "After this operation, you may still need to tweak the system to Vanilla GNOME or your personal preference. Also, you will have to select GNOME on Xorg when you login if you want to use Xorg as this script resets that setting."
	tput setaf 9
	echo "Standard Ubuntu is recommended although most functions should still work on Ubuntu-based distros with GNOME"
	echo "Some operations performed in this script are irreversible!!!"
	tput sgr0
	echo "Are you sure you want to continue? [y/N]"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		y)	debloat;;
		n)	mainmenu;;
		"")	mainmenu;;
		*)	badoptiondebloatconfirm;;
	esac
}
upgradetognome40confirm () {
	checkcompatibility40
	clear
 	tput setaf 3
	echo "============================================="
	echo " --- Confirmation to Upgrade to GNOME 40 ---"
	echo "============================================="
	echo "This will remove all Ubuntu customizations to GNOME and revert to Vanilla GNOME."
	echo "After this operation, you may still need to tweak the system to Vanilla GNOME or your personal preference. Also, you will have to select GNOME on Xorg when you login if you want to use Xorg as this script resets that setting. This will also upgrade your GNOME to 40."
	tput setaf 9
	echo "Standard Ubuntu is recommended although most functions should still work on Ubuntu-based distros with GNOME"
	echo "Some operations performed in this script are irreversible!!!"
	echo "GNOME 40 may still be unstable!!! Proceed at your own risk!!!"
	tput sgr0
	echo "Are you sure you want to continue? [y/N]"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		y)	upgradetognome40;;
		n)	mainmenu;;
		"")	mainmenu;;
		*)	badoptiongnome40confirm;;
	esac
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
badoptiondebloatconfirm () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Debloat Confirmation..."
	tput sgr0
	sleep 3
	debloatconfirm
}
badoptiongnome40confirm () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to GNOME 40 Upgrade Confirmation..."
	tput sgr0
	sleep 3
	upgradetognome40confirm
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
	checkcompatibilitygnome
	clear
	tput setaf 3
	echo "Full Install/All User Packages (Standard Ubuntu/GNOME)..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras gnome-backgrounds ubuntu-gnome-wallpapers synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gnome-boxes gparted vlc p7zip-full p7zip-rar gnome-tweaks lame gpart grub2-common neofetch network-manager-openvpn-gnome ffmpeg httraqt lsp-plugins tree telegram-desktop gufw easytag android-tools-adb android-tools-fastboot gnome-sound-recorder cheese nikwi supertux dconf-editor deja-dup gnome-todo gnome-sushi unoconv ffmpegthumbs fonts-cantarell gnome-books krita gnome-clocks gimp htop transmission curl git handbrake gnome-shell-extension-prefs gdebi gnome-weather gnome-firmware gucharmap menulibre minetest gtk-3-examples nautilus-admin python3-pip flatpak
	fullcommon
}
minimal () {
	checkcompatibilitygnome
	clear
	tput setaf 3
	echo "Minimal Install/Essentials (Standard Ubuntu/GNOME)..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gnome-tweaks gpart network-manager-openvpn-gnome ffmpeg gufw dconf-editor deja-dup gnome-sushi unoconv ffmpegthumbs fonts-cantarell htop curl git gnome-shell-extension-prefs gdebi gnome-firmware gucharmap menulibre gtk-3-examples nautilus-admin python3-pip flatpak
	minimalcommon
}
fulluniversal () {
	checkcompatibilitygnomeinv
	clear
	tput setaf 3
	echo "Full Install/All User Packages (Universal Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras gnome-backgrounds ubuntu-gnome-wallpapers synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gnome-boxes gparted vlc p7zip-full p7zip-rar lame gpart grub2-common neofetch network-manager-openvpn-gnome ffmpeg httraqt lsp-plugins tree telegram-desktop gufw easytag android-tools-adb android-tools-fastboot gnome-sound-recorder cheese nikwi supertux dconf-editor deja-dup gnome-todo ffmpegthumbs fonts-cantarell gnome-books krita gnome-clocks gimp htop transmission curl git handbrake gdebi gnome-weather gnome-firmware gucharmap menulibre minetest gtk-3-examples python3-pip flatpak
	fullcommon
}
minimaluniversal () {
	checkcompatibilitygnomeinv
	clear
	tput setaf 3
	echo "Minimal Install/Essentials (Universal Ubuntu)..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gpart network-manager-openvpn-gnome ffmpeg gufw dconf-editor deja-dup ffmpegthumbs fonts-cantarell htop curl git gdebi gnome-firmware gucharmap menulibre gtk-3-examples python3-pip flatpak
	minimalcommon
}
common () {
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
}
fullcommon () {
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo add-apt-repository -y ppa:linuxuprising/java
	echo oracle-java16-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
	sudo apt install -y oracle-java16-installer --install-recommends
	java -version
	sleep 3
	sudo add-apt-repository -y ppa:mkusb/ppa
	sudo apt install -y mkusb mkusb-nox usb-pack-efi gparted
	sudo add-apt-repository -y ppa:obsproject/obs-studio
	sudo apt install -y obs-studio
	sudo add-apt-repository -y ppa:nextcloud-devs/client
	sudo apt install -y nextcloud-client
	sudo apt update -y
	sudo apt full-upgrade -y --allow-downgrades
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update -y
	flatpak install -y flathub org.audacityteam.Audacity
	flatpak install -y flathub org.shotcut.Shotcut
	flatpak install -y flathub net.minetest.Minetest
	flatpak update -y
	flatpak uninstall -y --unused
	pip3 install pip youtube-dl yt-dlp speedtest-cli sysmontask -U
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
minimalcommon () {
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo apt update -y
	sudo apt full-upgrade -y --allow-downgrades
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	sudo snap refresh
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update -y
	flatpak uninstall -y --unused
	pip3 install pip speedtest-cli sysmontask -U
	gio mime text/calendar org.gnome.Calendar.desktop
	finish
}
debloatcommon () {
	sudo apt-mark manual shotwell remmina
	sudo apt update -y
	sudo apt install -y gnome-session vanilla-gnome-desktop vanilla-gnome-default-settings gnome-backgrounds
	sudo rm -f /usr/share/plymouth/ubuntu-logo.png
	sudo apt purge -y ubuntu-desktop
	sudo apt purge -y ubuntu-session
	sudo apt purge -y gnome-shell-extension-desktop-icons
	sudo apt purge -y gnome-shell-extension-desktop-icons-ng
	sudo apt purge -y gnome-shell-extension-ubuntu-dock
	sudo apt purge -y yaru*
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
	gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
}
debloat () {
	clear
	tput setaf 3
	echo "Debloating..."
	tput sgr0
	sleep 3
	clear
	debloatcommon
	finish
}
upgradetognome40 () {
	clear
	tput setaf 3
	echo "Upgrading to GNOME 40..."
	tpu sgr0
	sleep 3
	clear
	debloatcommon
	sudo add-apt-repository -y ppa:shemgp/gnome-40
	sudo apt purge -y libpango-1.0-0:i386
	sudo apt install -y gnome-session adwaita-icon-theme-full fonts-cantarell
	sudo apt full-upgrade -y
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	finish
}
# End of Function Cluster
# Start of Main Script
while true
do
	checkcompatibility
	mainmenu
done
# End of Main Script
