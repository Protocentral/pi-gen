#!/bin/sh -e

# Delete this in production
#ROOTFS_DIR="/Users/akw/Documents"

healthypi_loc="https://github.com/Protocentral/protocentral_healthypi_v4/releases/latest/download/healthypi-rpi.zip"

wget "$healthypi_loc" -O "files/healthypi.zip"

rm -r {ROOTFS_DIR}/HealthyPi ||:
rm -r files/application.linux-armv6hf ||:
unzip files/healthypi.zip -d files/
mv files/application.linux-armv6hf/* files/
rm -r files/application.linux-armv6hf

#mkdir ${ROOTFS_DIR}/HealthyPi
install -v -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi"
install -v -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/lib"
install -v -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/data"

install -m 777 "files/gui" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/gui"
chmod +x ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/gui

for file in files/lib/*;do
    install -m 755 "$file" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/lib"
done

for file in files/data/*;do
    install -m 755 "$file" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/data"
done

#sed -i -e "${ROOTFS_DIR}\/home\/${FIRST_USER_NAME}\/HealthyPi\/gui/d" ${ROOTFS_DIR}/etc/xdg/lxsession/LXDE-pi/autostart
echo "@/home/${FIRST_USER_NAME}/HealthyPi/gui &" >> ${ROOTFS_DIR}/etc/xdg/lxsession/LXDE-pi/autostart

#rm "${ROOTFS_DIR}/usr/share/rpd-wallpaper/temple.jpg"
install -v -m 644 "files/proto.jpg" "${ROOTFS_DIR}/usr/share/rpd-wallpaper/temple.jpg"
sed -i '/console=serial0,115200/d' "${ROOTFS_DIR}/boot/cmdline.txt"

#install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi"
#install -v -o 1000 -g 1000 -m 644 "files/$magpi_latest" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/HealthyPi/"

#install -v -o 1000 -g 1000 -m 644 "files/$magpi_latest" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/MagPi/"
