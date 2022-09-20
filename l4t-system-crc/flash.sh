#!/bin/bash

echo "docker run -it --rm --privileged --net=host -v /dev/bus/usb:/dev/bus/usb reeplayer/camera-sw:l4t-system-crc-nx-32.7.2-6 bash"
docker run -it --rm --privileged --net=host -v /dev/bus/usb:/dev/bus/usb reeplayer/camera-sw:l4t-system-crc-nx-32.7.2-6 bash