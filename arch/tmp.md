# Configure Arch Linux

## 1. Complete a base installation
Follow the [installation guide](https://wiki.archlinux.org/title/Installation_guide) on the Arch Linux wiki.

- When running `pacstrap`, be sure to include the following packages.
```bash
pacstrap -K /mnt base linux linux-firmware python sshd grub vim sudo curl
```
* Python is required by Ansible
* sshd is required for this host to be one of the remote hosts the playbook will run on
* grub will be required when configuring the boot loader
* vim (just in case)
* sudo (to enable privilige escalation on non root accounts)
* curl (possibly not needed in pacstrap as Ansible will install it in the pacman role)

- When chrooted into the system, ensure that you enable openssh
```bash
sudo systemctl enable sshd
```

- A new user should also be created whilst chrooted
```bash
useradd -m -G wheel <user name>
passwd <user name>
```

- The `wheel` group should also be modified to enable members to execute any command
```bash
cp /etc/sudoers.example /etc/sudoers
vim /etc/sudoers
```

- Set up [GRUB](https://wiki.archlinux.org/title/GRUB) as the boot loader

- If using a wireless connection, be sure to also set up the network manager.



## 2. Set up SSH connectivity on the remote host
1. On the controller, create a new SSH pub/private key pair
```bash
ssh-keygen -t ed25519 -C "os-config"
```

2. Find the IP address of the remote host to run the playbook on (requires direct access)
```bash
ip a
```

3. Copy the public SSH key onto the remote host
```bash
ssh-copy-id -i ~/.ssh/os_config_id_ed25519.pub sam@<ip gathered from step 3>/home/sam/.ssh/authorized_keys
```


## 3. Run the playbook
In order to run the playbook on a remote host, first the `inventory` file needs to be updated with the IP address
This repository has a `scripts` directory containing a script that will run the ansible playbook on the host.

Note that this must be done on the same network as the remote host.

The local IP address can be determined on the remote host with:
```bash
ip a
```
Update the IP address located in the `inventory` file on the controller before running with the new IP address.

You can then run the installation script that will trigger the playbook with:
```bash
sh scripts/base-install.sh
```
This must be ran from the repository directory `./os-config/arch`.
