# My clone-and-go NixOS configuration files

### Pre-installation

#### Step 1

Firstly, get into a nix shell with git and clone this repository:

````
git clone https://github.com/PastaG1903/.dotfiles --branch nixos
````
Get to the directory of the relevant host and identify the ````disk-config.nix```` file.

Alternatively, you can simply run the following command to get the same ````disk-config.nix```` file:

````
curl https://raw.githubusercontent.com/PastaG1903/.dotfiles/nixos/hosts/<hostname>/disk-config.nix -o disk-config.nix
````

#### Step 2

Next, run the following command to run Disko to format and mount your storage device:
````
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- -m destroy,format,mount /path/to/disk config.nix
````
**Make sure you change the "device" field on line 10.**

### System installation

> [!NOTE]
> Please go to [this section](https://github.com/PastaG1903/.dotfiles/blob/nixos/hosts/README.md) for host-specific considerations.

At this point, all the partitions and subvolumes will be mounted under /mnt.

If you didn't clone the repository as stated earlier, this is the point to do it.
I would personally recommend to get into /mnt/home, create the directory for you user, and cloning the repository there (or moving it if already cloned).

#### Step 1

Go ahead and run ````nixos-generate-cofig --root /mnt```` to generate the ````hardware-configuration.nix```` file under ````/mnt/etc/nixos/````.
Go ahead and move that file to the directory of the host that you chose earlier, replacing the one that already exists.

#### Step 2

To install, run the following command to install according to the ````flake.nix````, changing the hostname accordingly:
````
nixos-install --flake /path/to/flake#hostname
````

#### Step 3

If the installation is completed without errors, the user defined inside ````configuration.nix```` should have been created.
So, run ````nixos-enter --root /mnt -c 'passwd <username>'```` to set up the password for your user, unless you decided to declare in the configs (e.g. using the initialPassword or hashedPassword options).
Then, the system should be good to reboot into it.

### Home manager installation

Supposing you did get the cloned repository into your user directory (although it really can be anywhere), you just need to run the following command:
````
nix run github:nix-community/home-manager -- switch --flake /path/to/flake#username
````
That's it. It all should be good to go.
