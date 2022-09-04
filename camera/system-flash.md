# Overall workflow 

We may run some "custom" installation commands before and aftert the flash of the system. A specific task, e.g. install the mcutool, or set the serail number for camera, could be done before or after the flash, to satisfy different requirements. 

1. Pre-flash commands 

The "pre-flash" commands refer to the commands run before we issue the real "flash" command, but after we launch the docker container used for flash. We must use bellow command to force the docker container to stop before the "flash" command, so that we have a chance to run the "pre-flash" commands. (If we run below command without the trailing "bash", the docker container will run the default "pre-flash" commands and then run the "flash" command immediately, so there is no chance to run the "pre-flash" commands.)

    ./flash.sh reeplayer/camera-sw:l4t-system-crc-nx-32.7.2-5 bash 

The supported "pre-flash" commands include: 

    * ./system-tools/install-mcutool.sh (it has been installed by default in current version)
    * ./system-tools/set-serial.sh -s <serial> -t <token>
    * ./system-tools/set-wifi-ap.sh -a <address> -s <ssid> -p <password>
    * ./system-tools/set-wifi-station.sh -s <ssid> -p <password>
    * ./system-tools/install-camera.sh <version> (not implemented yet)

2. Flash command 

After run the "pre-flash" command, we may issue bellow "flash" command to really flash the "built" system image with above "pre-flash" commands. 

We may repeatedly run the "flash" command, with or without running the "pre-flash" commands before each "flash". For example, we may run the "set-serial" command before each "flash" to set a unique serial number for each device. If we do not exit the "flash" docker container, the installation or setup done by the "pre-flash" commands will be applied (shared) to all following "flash", which avoid we run the install or set command one each device one by one. 

In addition, if we "flash" the same system image for all devices (without different "pre-flash" commands for each device), we may cache the system image to avoid repeat the build process on each "flash" cammand, with below commands sequence:  

    ./flash.sh --no-flash jetson-xavier-nx-crc mmcblk0p1 
    ./flash.sh -r jetson-xavier-nx-crc mmcblk0p1 
    ./flash.sh -r jetson-xavier-nx-crc mmcblk0p1 
    ... 

3. Post-flash commands 

The "post-flash" commands refer to the commands run after the flash, specifically, run through SSH session after the system start. The supported "post-flash" commands include: 

    * ./system-tools/install-mcutool.sh (if not installed before flash)
    * ./system-tools/set-nvme.sh (*** this must be run once after flash)
    * ./system-tools/set-serial.sh -s <serial> -t <token> (*** this must run once to set the serial number)
    * ./system-tools/set-wifi-ap.sh -a <address> -s <ssid> -p <password>
    * ./system-tools/set-wifi-station.sh -s <ssid> -p <password>
    * ./system-tools/install-camera.sh <version> (*** this must run once to install a version of the camera software)

4. Notes for commands 

The mcutool could be installed both before or after the flash, which give us a chance to not install the mcutool, to save the storage, if the power control MCU has been flashed already with other system or last installation. (The mcutool was installed by default now. My optional in future version.) 

We need to run "install-nvme" command only once after the system flash. It will format the nvme SSD drive and setup the auto mount of the drive to "/mnt/data". The command "install-nvme" is only available for "post-flash" operations. 

The "set-wifi-*" commands could be run both before and after the flash, to setup the network. 

Because we have not implemented the serial set in web gui or mobile app, so we must run the "set-serial" before or after flash, to set the serial number for camera. 

When the "install-camera" command run before flash, it only install the camera software system if a specific "version" is given, otherwise, it will only copy the installation tools to support the "post-flash" installation. (The pre-flash installation is not supported yet.)


-----------------------------------------------------------------------------------------
# Connect to the system after flash 

Once the camera system startup, it will establish a WiFi access point (AP) as below: 

    SSID: Reeplayer 
    Password: Reeplayer
    IP: 10.0.0.1 

It will also created a default user account as below: 

    username: reeplayer 
    password: reeplayer

Access the device system through SSH: 

    ssh reeplayer@10.0.0.1 


---------------------------------------------------------------------------------------------------

# Install docker engine on host computer 

    https://docs.docker.com/engine/install/ubuntu/


# Pull the docker image for the system flash  

Pull the docker image from docker.com 

    docker pull reeplayer/camera-sw:l4t-system-crc-nx-32.7.2-5 

# Set Jetson module into recovery mode 

Connect the USB cable of the device to the host computer, and startup the device to "recovery" mode. 

If the Jetson Xavier NX module is not flashed before (empty module), then it will enter the "recovery" mode by default after power on. 

If the Jetson Xavier NX module has been flashed with a L4T system and it still works, then start the system, and use below command in the terminal to restart the system, it will enter the "recovery" mode after restart. 

    sudo reboot --force forced-recovery 

If the Jetson Xavier NX module has been flashed, but it can not startup correctly, then we have to use the "test pad" to set the system into "recovery" mode. 

**If the Jetson module is an empty one, it will enter "recovery" mode by default after power on. But you may need to start the flash command in a short time window after the power on, otherwise the flash tool may be failed to detect the device.**

