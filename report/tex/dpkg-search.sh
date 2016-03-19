jonas@debian:/var/log/apt$ # Hämta sökväg till programmet 'sudo'
jonas@debian:/var/log/apt$ echo $(which sudo)
/usr/bin/sudo
jonas@debian:/var/log/apt$ # Ta reda på vilket paket som innehåller ovanstående sökväg
jonas@debian:/var/log/apt$ dpkg -S $(which sudo)
sudo: /usr/bin/sudo
