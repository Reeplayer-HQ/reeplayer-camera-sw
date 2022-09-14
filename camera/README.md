# Reeplayer Camera Software 

## Initially install the Reeplayer camera software 

To initially install the Reeplayer camera software on the Reeplayer camera, you need complete below steps: 

    1. Flash the customized the L4T system for the Reeplayer camera 
    2. SSH to the camera system (please follow the guide of the camera system installation)
    3. Run the "install-nvme.sh" to mount the SSD drive (if the NVMe SSD card is installed)

Then, the Reeplayer camera software (version x.x.x) could be installed with below command on the SSH session: 

    cd ~/system-tools 
    ./install-camera.sh x.x.x 

## Auto upgrade the Reeplayer camera software 

In the built-in WebUI of the Reeplayer camera software, and the mobile app, the user could check the Reeplayer camera software versions, and upgrade to the latest version. 
