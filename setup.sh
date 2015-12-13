#!/bin/bash
## Description: Setup script for AMD ATI/Intel Indicator
## Tested on Mint 17.3 and Catalyst (fglrx) 15.200.xxxx

if (( $EUID )); then
	echo "This script must be run using sudo" 2>&1
	exit 1
fi

echo 'Installer for "amd-indicator":'
echo -e "\tAMD ATI/Intel Indicator applet for Linux Mint laptop users with AMD/Intel switchable graphics."

# There was a problem in some programs with finding i965_dri.so file
# so we'll try to add the missing links ourselves
if [[ -d /usr/lib/x86_64-linux-gnu && -d /usr/lib/fglrx/dri ]]; then
	sudo ln -s /usr/lib/x86_64-linux-gnu/dri/i965_dri.so /usr/lib/fglrx/dri/i965_dri.so
	sudo ln -s /usr/lib/x86_64-linux-gnu/dri/i965_dri.so /usr/lib/fglrx/dri/i965dri.so
fi

#
echo 'Removing any possibly already installed instances...'
#

rm -f /usr/bin/amd-indicator
rm -Rf /usr/local/amd-indicator

# Create all required application directories
mkdir -p /usr/local/amd-indicator/resources

#
echo 'Copying AMD Indicator application files to "/usr/local/amd-indicator"...'
#

cp amd-indicator /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/amd-indicator
chmod 755 /usr/local/amd-indicator/amd-indicator
# Add a link to our application, in user local binaries
ln -sf /usr/local/amd-indicator/amd-indicator /usr/local/bin/amd-indicator

# Copy discrete GPU-related scripts
cp dgpuon /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/dgpuon
chmod a+x /usr/local/amd-indicator/dgpuon

# Copy integrated GPU-related scripts
cp igpuon /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/igpuon
chmod a+x /usr/local/amd-indicator/igpuon

# Copy dark theme scripts
cp dark-theme-icons /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/dark-theme-icons
chmod a+x /usr/local/amd-indicator/dark-theme-icons

# Copy light theme scripts
cp light-theme-icons /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/light-theme-icons
chmod a+x /usr/local/amd-indicator/light-theme-icons

# Copy application 'restart' scripts
cp restart /usr/local/amd-indicator/
chown root:root /usr/local/amd-indicator/restart
chmod a+x /usr/local/amd-indicator/restart

## Copy user logout scripts
cp logout-user /usr/local/amd-indicator/
chmod a+x /usr/local/amd-indicator/logout-user

# Copy and link amd.png to /usr/local/amd-indicator/
cp resources/amd-dark.png /usr/local/amd-indicator/resources
cp resources/amd-light.png /usr/local/amd-indicator/resources
# Set dark theme as default
ln -s /usr/local/amd-indicator/resources/amd-dark.png /usr/local/amd-indicator/amd.png

# Copy and link intel.png to /usr/local/amd-indicator/
cp resources/intel-dark.png /usr/local/amd-indicator/resources
cp resources/intel-light.png /usr/local/amd-indicator/resources
# Set dark theme as default
ln -s /usr/local/amd-indicator/resources/intel-dark.png /usr/local/amd-indicator/intel.png
# Allow read permissions for everyone
chmod a+r /usr/local/amd-indicator/*.png

#
echo "Configuring fakeroot security policy for AMD Catalyst Control Center access..."
#

cp -f amd-indicator-sudoers /etc/sudoers.d/
chmod 644 /etc/sudoers.d/amd-indicator-sudoers

#
echo 'Setting up auto-start and menu launchers...'
#

# Add auto-start launcher
cp -f amd-indicator.desktop /etc/xdg/autostart/
# Add launcher to user applications
cp -f amd-indicator.desktop /usr/share/applications/

echo 'All done! Search for "AMD ATI/Intel GPU Indicator" in your Mint applications Menu...'
