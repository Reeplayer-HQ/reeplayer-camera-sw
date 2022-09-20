# Camera software system installation (Jetson Xavier NX on Capable Robot carrier board)

## Prepare the host computer for the installation 

The first step to install the camera software system is to flash the customized L4T system (Linux for Tegra) to the camera device, which needs a host computer running Ubuntu 18.04 or 20.04. (Other versions should work too. Please report if you tested and found issues). 

The L4T system image is carried by a docker container. The installation commands are also run in the docker container. So you need to install the docker engine on the host computer. Below is the page for the official guide to install docker engine on Ubuntu system. 

    https://docs.docker.com/engine/install/ubuntu/

Either methods in the guide, e.g. "Install using the repository" or "Install from a package" should work. 

After the installation, please go to the "Post-installation steps for Linux" through the link on the bottom of above page, or through below link: 

    https://docs.docker.com/engine/install/linux-postinstall/

Complete the operations in the first part "Manage Docker as a non-root user" in above page. 


## Prepare the camera device for the installation 

First connect the camera device to the host computer with the USB cable. 

Then start the camera device into "recovery" mode. There are three cases here to set the Jetson module in the camera device to "revocery" mode. 

1. If the Jetson module is installed for the first time, so there is no L4T system in the eMMC storage, then the Jetson module may be booted into "recovery" mode when it is powered on. 

On the host computer, open a terminal and input below command to check if the Jetson module has been in "recovery" mode: 

    lsusb 

If the Jetson module is booted into "recovery" mode, you should see a line in the output like below: 

    Bus 00x Device 00x: ID 0955:7e19 NVIDIA Corp. APX

2. If there is a L4T system already installed on the camera device, and you can start the L4T system successfully, then you may force the Jetson module booted into "recovery" mode by command line options for the "reboot" command. 

Please refer to the below section "Connect to the camera device through network (SSH)" to establish the network connection from the host computer to the camera device, either through the camera's WiFi AP or the local network (network router), and login the camera system with the "ssh" command. 

On the SSH session, you may restart the camera device and force the Jetson module booted into "recovery" mode, with below command: 

    sudo reboot --force forced-recovery 

Mostly, you will see the output as below, and then the terminal session is frozen. 

    Rebooting with argument 'forced-recovery'.

You may close the terminal window. And check if the Jetson module has been in "recovery" mode with the method in case 1. 

*Plese note that because a bug in the power control MCU, the camera device may fail to reboot into recovery mode with above command. The workaround is to unplug the cable from the power button to disable the power button, and if necessary, disconnect and re-connect the battery. Then repeat above steps to login the system with SSH and issue the reboot command, until the Jetson module is successfully booted into the "recovery" mode.* 


3. If neither above case 1 nor case 2 works, you have to use the harware "reset" pad on the carrier board to force the camera device into the "recovery" mode. 

There is a printed "pad" on the carrier board, near the "ethernet" connector, marked as "tp39", served as the "reset" button to force the Jetson module into "recovery" mode. You need to connect the "reset" pad to the "ground" of the carrier board, during the first several seconds when the device is powered on (e.g. by re-connecting the battery). There are many "ground" points on the carrier board, one of which is the "GND" hole of the "j1" connector near the power connector. 

Please be careful when you connect the "reset" pad to the "ground". Also use the same method in case 1 to check if the Jetson module has been in "recovery" mode. 


## Download the installation guide and tool 

Please find the released versions of L4T system on below page, which is named as "Camera System x.x.x": 

    https://github.com/Reeplayer-HQ/reeplayer-camera-sw/releases

Download the "camera-system-x.x.x.tar.gz" file in the "Assets" under the target version. You may uncompress the downloaded file to a proper location of the host computer with the GUI tool, or below command in a terminal window: 

    tar -xzvf camera-sytem-x.x.x.tar.gz 

In the output folder, you will find a README.md file (this guide), a script file "flash.sh", and other tools (if exists). The real system image is in a docker container, which will be pulled by the "flash.sh" when you run it.  


## Install the L4T system

To start the installation of the L4T system to the camera device, run the "flash.sh" from the released version, as below. Let's suppose you have uncompressed the downloaded file into "~/camera-system-x.x.x" in above step. 

    cd ~/camera-system-x.x.x 
    ./flash.sh 

If this is the first time to run the script of this version, it will pull the docker image that contains the L4T system, which may take severial minutes. 

Once the docker image has been pulled to the host computer, the script will run the docker container, and complete some pre-defined operations as below: 

    1. Create the default user name for the camera as "reeplayer". 
    2. Downlaod the latest tools that used to flash the firmware to the power control MCU, and setup the systemd service for power control. 
    3. Set the ethernet interface working in DHCP mode. 
    4. Set the camera's WiFi access point (AP) with IP address "10.0.0.1", SSID "Reeplayer", and password "Reeplayer".
    5. Set the camera's WiFi interface (as client/station) with SSID "Guest" and empty password. 

You need to check the output information to make sure there is no error occured, and finally the docker container is running with below output in the terminal: 

    ...
    Install the system tools
    Created symlink /etc/systemd/system/default.target -> /lib/systemd/system/multi-user.target.
    Camera software version is not given, skip the installation!
    root@host-ubuntu:/Linux_for_Tegra# 

To this point, the tool is still preparing the L4T system that will be installed into the camera device. Before the real flashing of the L4T system, we can run a series of commands now to customize the L4T system. These commands run before the flash of the system, so are called "pre-flash" commands. Please note that some of the commands could also run after the flash, which are called "post-flash" commands. The difference is, if you are flashing multiple devices at the same time, the results of "pre-flash" commands will be applied to all of the devices, while the "post-flash" commands only apply to the current device.  

The scripts for the commands is in the folder "system-tools", so the command (e.g. set-serial) should be run as below: 

    cd system-tools 
    ./set-serial.sh -s <serial-number>

The supported "pre-flash" commands include: 

    1. install-mcutool.sh (it has been called as a pre-defined operation when run the docker container, so you do not need to run it again.)
    2. set-serial.sh -s <serial-numer> -t <token> (you may run it to set a unique serial number for the caemra. the token is optional, for testing installation only)
    3. set-wifi-ap.sh -a <address> -s <ssid> -p <password> (you may run it to set unique WiFi AP SSID and password)
    4. set-wifi-station.sh -s <ssid> -p <password> (you may set the known WiFi SSID and password if you hope the camera can connect to the WiFi hotspot when start.)
    5. set-service.sh -d <true | 1> -u <service URL for dev mode> (you may run it to set the camera into "dev" mode. The service URL for dev mode could be set with -u option. If the URL is not set, the default URL "https://api.dev.reeplayer.com" will be used.)
    6. install-camera.sh <version> (install the camera software. It is not implemented yet, please do it with post-flash command.)

Once you complete the necessary pre-flash commands, you may issue command to do the real flash. There are three commands you may run, which are for different purposes. 

    ./flash.sh --no-flash jetson-xavier-nx-crc mmcblk0p1 (this command will prepare the system image, but not flash it to the camera really.)
    ./flash.sh -r jetson-xavier-nx-crc mmcblk0p1 (this command will flash the "prepared" system image to the camera, so it will be quick.)
    ./flash.sh jetson-xavier-nx-crc mmcblk0p1 (this command will ignore the "prepared" system image in preview flash command, it re-build the system image and flash to the camera.)

In above commands, the "jetson-xavier-nx-crc" is the device id in the flash tool, the "mmcblk0p1" is the target location of the system software, it is the eMMC storage of the Jetson module in this case. 

It is easy to understand that if you will flash multiple camera devices, you may repeat to run some of above commands to speedup the process. It is not necessary to exit the docker container and run the docker container for each of the camera devices. But please remember that, before flash to a camera device, if you have run one or more pre-flash commands to setup specific information for current camera, e.g. set the unique serial number, or the WiFi AP SSID and password, you must re-build the system image, by avoiding to use the "-r" option in the flash command.  

If the "flash" process is done successfully, you will see the information on the screen that ask you to restart the camera device to run the installed system. 


## Connect to the camera device through network (SSH)

The Capable Robot carrier board has no interface to connect local monitor, so after the L4T system is installed and started succeffully, the only way you login the camera system is through network. There are two ways to establish the network connection between the host computer and the camera device, and login the camera system through a SSH session. 

1. Connect the host computer to the camera device through the camera's WiFi access point (AP) 

Here we suppose the camera device has successully started with the WiFi AP enabled, and the host computer has a WiFi adapter. The camera's WiFi AP could be configured with the pre-flash cammand (set-wifi-ap) or post-flash command (set-wifi-ap). The default setup is as below: 

    IP: 10.0.0.1 
    SSID: Reeplayer (mostly has been reset to "Reeplayer-xxxx")
    Password: Reeplayer (mostly has been reset to a secret password)

You may find the WiFi SSID in the list of "WiFi networks" on the host computer, which is mostly in the format of "Reeplayer-xxxx". You need to know the password to establish the WiFi connection. Let's suppose the IP of the WiFi AP is the default one, and the user name of the camera system is also the default one, then once the WiFi connection is established, you may login the camera system with below command in terminal. 

    ssh reeplayer@10.0.0.1 

2. Connect both the camera device and the host computer to the same local network or a same network router  

The camera device could connect to the local network (network router) with a ethernet cable or WiFi connection (as WiFi client/station). With either way, the camera device will be assigned a IP address from the router. You need to find a way to tell the camera's IP address, for example through the router's admin page (the name of camera device is "camera" by default). We also connect the host computer to the same local network (network router) with ethernet cable or WiFi connection (as WiFi client/connection). Please note that if the camera is connected to the local network with both the ethernet cable and the WiFi, the camera will have two different IP addresses on the ethernet interface and the WiFi interface. Either of the IP addresses could be used as the camera's IP in following operations. 

Let's suppose the camera's IP on the ethernet interface or the WiFi interface is "192.168.1.235", and the user name of the camera system is the default one, then you may login the camera system with below command in terminal: 

    ssh reeplayer@192.168.1.235 

In either case of above, if you failed to login with the ssh command, you may verify the network connection with below command in a terminal (let's suppose the camera's IP from above steps is x.x.x.). 

    ping x.x.x.x 

If the network connection has established and the IP address is correct, you will see below output: 

    PING 10.0.0.1 (10.0.0.1) 56(84) bytes of data.
    64 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=1.39 ms

Otherwise, you will see below output, or there is output at all.

    PING 192.168.1.225 (192.168.1.225) 56(84) bytes of data.
    From 192.168.1.162 icmp_seq=1 Destination Host Unreachable


## Prepare and install the Reeplayer camera software 

Once the L4T system was successfully flashed to the camera device, and you can connect to the camera through SSH as above section, you may run the "post-flash" commands to setup the system, and install the Reeplayer camera software. 

The scripts for the "post-flash" commands are in "~/system-tools" folder, so the command (e.g. set-serial) should run as below: 

    cd ~/system-tools 
    ./set-serial.sh -s <serial-number>

The supported "post-flash" commands include: 

    1. install-mcutool.sh (this command has been run before the flash as a pre-defined operation, so you do not need to run it now, unless it is necessary.)
    2. set-serial.sh -s <serial> -t <token> (this command should run once before or after flash to set the unique serial number for the camera.)
    3. set-wifi-ap.sh -a <address> -s <ssid> -p <password> (if the camera need a unique WiFi AP SSID and password, then run this command before or after flash to set it.)
    4. set-wifi-station.sh -s <ssid> -p <password> (it is optional to set the known WiFi hotspot so the camera can establish the WiFi connection (as WiFi client/station) after start.)
    5. set-nvme.sh (!!! this command must run once to install the SSD drive.)
    6. set-service.sh -d <true | 1> -u <service URL for dev mode> (you may run it to set the camera into "dev" mode. The service URL for dev mode could be set with -u option. If the URL is not set, the default URL "https://api.dev.reeplayer.com" will be used.)
    7. install-camera.sh <version> (!!! this should run once to install the Reeplayer camera software)

1. Flash the firmware for the power control MCU 

We need to flash the latest firmware to the power control MCU on the carrier board. So you need to run below commands for a camera device at least once, unless you know the firmware in the MCU has been the latest version, for example, you just re-flash the L4T system and know there is no update for the MCU firmware since last time you flash it. 

The MCU flash tools and relevant power control service have been installed as the pre-defined operation before the L4T system flash, so you do not need to run the "install-mcutool.sh" before and after the flash, and before below commands: 

    cd ~ 
    mcutool flashos 

    mkdir firmware 
    cd firmware 

    mcutool fetchcode 
    mcutool flashcode 
    mcutool reboot 

2. Install the Reelayer camera software 

Before install the camera software, please do not forget to run the "install-nvme.sh" to install the SSD drive, and run the "set-serial.sh" and "set-wifi-ap.sh" to set the unique serial number, the unique WiFi AP SSID and password, if it is necessary. 

Pleae check the released verions of the Reeplayer camera software on below page, which are named as "Camera Software x.x.x": 

    https://github.com/Reeplayer-HQ/reeplayer-camera-sw/releases

Mostly, you should install the lasted version on current camera device, let's suppose the latest version is x.x.x, then you should run below command on the SSH session: 

    cd ~ 
    cd system-tools 
    ./install-camera.sh x.x.x 

Please check the output to make sure there is no error happened in the installation. If this is the first time to install the Reeplayer camera software, it will pull the docker images for the camera software, which may take several minutes according to the Internet speed. Once the camera software is installed successfully, it will ask you to restart the camera device. 

3. Test the camera software system with the WebUI 

Once the Reeplayer camera software is installed successfully, you may test the software functions with the built-in WebUI. Please follow the above section "Connect to the camera device through network (SSH)" to establish the network connection from host computer to the camera device, either through camera's WiFi AP, or the local network (network router). Remeber the IP address of the camera, for example, it may be "10.0.0.1" on the WiFi AP connection, and "192.168.1.235" on the ethernet interface or WiFi interface when it connects to the local network (network router). It is not necessary to "SSH" to the camera system. Let's suppose the camera's IP is x.x.x.x, then open the web browser on the host computer with below URL: 

    http://x.x.x.x 


4. Test the camera software system with the mobile app 

Once the Reeplayer camera software is installed successfully, you may test the software functions with the mobile app. 
