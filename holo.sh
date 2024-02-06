sudo apt-get update && apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86-xen -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw windows7nano.img 64G
wget -O windows7_super-nano_lite.iso 'https://cd2.holoiso.ru.eu.org/holoiso-installer/holoiso_beta_snapshot20240125.1712.26-INSTALLER-06-x86_64.iso'

curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=windows7_super-nano_lite.iso,media=cdrom \
  -drive file=windows7nano.img,format=raw \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu core2duo \
  -smp cores=4 \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
