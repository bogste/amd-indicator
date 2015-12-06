#!/bin/bash

if (( $EUID )); then
	echo "This script must be run using sudo" 2>&1
	exit 1

fi

echo 'Installer for "amd-indicator":'
echo -e "\tIndicator applet for Linux Mint laptop users with AMD/Intel switchable graphics."

# There was some problems in some programs with finding i965_dri.so file
if [[ -d /usr/lib/x86_64-linux-gnu && -d /usr/lib/fglrx/dri ]]; then
	sudo ln -s /usr/lib/x86_64-linux-gnu/dri/i965_dri.so /usr/lib/fglrx/dri/i965_dri.so
	sudo ln -s /usr/lib/x86_64-linux-gnu/dri/i965_dri.so /usr/lib/fglrx/dri/i965dri.so
fi

# Cleanup scripts
echo 'Removing any possibly already installed instances...'
#
rm -f /usr/bin/amd-indicator
rm -Rf /usr/local/indicator-amd

#
echo 'Copying AMD Indicator application files to "/usr/local/indicator-amd"...'
#
mkdir -p /usr/local/indicator-amd
cp amd-indicator /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/amd-indicator
chmod 755 /usr/local/indicator-amd/amd-indicator
ln -sf /usr/local/indicator-amd/amd-indicator /usr/local/bin/amd-indicator

cp dgpuon /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/dgpuon
chmod a+x /usr/local/indicator-amd/dgpuon

cp igpuon /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/igpuon
chmod a+x /usr/local/indicator-amd/igpuon

cp dark-theme-icons /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/dark-theme-icons
chmod a+x /usr/local/indicator-amd/dark-theme-icons

cp light-theme-icons /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/light-theme-icons
chmod a+x /usr/local/indicator-amd/light-theme-icons

cp restart /usr/local/indicator-amd/
chown root:root /usr/local/indicator-amd/restart
chmod a+x /usr/local/indicator-amd/restart

## Copy user logout scripts
cp logout-user /usr/local/indicator-amd/
chmod a+x /usr/local/indicator-amd/logout-user

# cp amd.png /usr/local/indicator-amd/
cp amd-dark.png /usr/local/indicator-amd/
cp amd-light.png /usr/local/indicator-amd/
ln -s /usr/local/indicator-amd/amd-dark.png /usr/local/indicator-amd/amd.png

# cp intel.png /usr/local/indicator-amd/
cp intel-dark.png /usr/local/indicator-amd/
cp intel-light.png /usr/local/indicator-amd/
ln -s /usr/local/indicator-amd/intel-dark.png /usr/local/indicator-amd/intel.png

chmod a+r /usr/local/indicator-amd/*.png

#
echo "Configuring fakeroot security policy for AMD Control Center access."
#
cp -f amd-indicator-sudoers /etc/sudoers.d/
chmod 644 /etc/sudoers.d/amd-indicator-sudoers

#
echo 'Setting up launchers...'
#
cp -f amd-indicator.desktop /etc/xdg/autostart/
cp -f amd-indicator.desktop /usr/share/applications/

#
echo 'All done! Search for "AMD ATI/Intel GPU Indicator" application in your Mint Menu...'
