function morgen
	 sudo cryptsetup open /dev/sda backup
	 sudo mount /dev/mapper/backup /mnt/backup
	 sudo apt update && sudo apt upgrade -y
	 git idm use work
end
