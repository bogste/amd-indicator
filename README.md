AMD Indicator
=============

Indicator applet for Ubuntu laptop users with AMD/Intel switchable graphics

This indicator applet allows owners of laptops with AMD/Intel hybrid graphics capabilities to
easily switch between the graphics cards without the need of running CCC or terminal commands.
This indicator also features a workaround for people using 64 bit Ubuntu, which usually has
a problem running 32 bit OpenGL applications/games on the integrated GPU with fglrx installed.
(Seriously, why would I even have to have the Radeon GPU running to play Counter Strike 1.6 under Wine?)

Prerequisites
==============
You have to have a few packages installed on your Ubuntu box to take advantage of this indicator.
Make sure you have the AMD driver. In case the indicator doesn't start because it is missing the python module "appindicator", again, make sure to install missing packages. To install all needed dependencies:
sudo apt-get install nvidia-prime nvidia-331 nvidia-settings python-appindicator

How to install
==============

# Make the setup.sh file executable and run it using sudo

chmod a+x setup.sh
sudo ./setup.sh