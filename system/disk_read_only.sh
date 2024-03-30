sudo umount -f /dev/nvme1n1p2
sudo ntfsfix /dev/nvme1n1p2 # where x is HDD and X is drive number, in my case it was /dev/sda1
sudo mount /dev/nvme1n1p2 /mnt/sda1
