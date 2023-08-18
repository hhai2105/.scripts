sudo umount -f /dev/nvme0n1p5
sudo ntfsfix /dev/nvme0n1p5 # where x is HDD and X is drive number, in my case it was /dev/sda1
sudo mount /dev/nvme0n1p5 /mnt/sda1
