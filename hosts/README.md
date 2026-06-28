# Per-host considerations

### Hermes

_Hermes_'s ````configuration.nix```` file includes configuration for zswap, preferred over zram (see line 41) for hibernation.

After _Step 1_ of the _System installation_, ````touch /mnt/swap/swapfile````.
Next, run ````btrfs inspect-internal map-swapfile /mnt/swap/swapfile```` and write the value of _Resume offset_ in line 17.

Finally, go to ````hardware-configuration.nix```` and get the UUID of the partition where your ````/swap```` is and write it on line 33 of ````configuration.nix````.

If you prefer to not have any swap or follow this steps _after_ the installation, go ahead and comment (or delete) the following lines in ````configuration.nix````:

* 24 to 29
* 33
* 42 to 45

Additionally, if you prefer zram, simply uncomment line 41, which will give you zram half the size of your RAM.

### Gnå

Firstly, _Gnå_ has zram enabled by default. You may follow the instructions above for _Hermes_ if you want zswap instead.

In her ````hardware-configuration.nix````, you can see that there is a filesystem mounted at ````/home/shay/Z-Drive````, which corresponds to a USB drive that was set to automount as soon as the system boots up.
This drive is meant to be used to sync files using Syncthing.

To achieve this, mount the drive manually at your desired mountpoint and regenerate the configuration using ````nixos-generate-config````, to get a new ````hardware-configuration.nix```` file with the drive listed.

You will see in lines 112 to 115 of ````configuration.nix```` the Syncthing service mounts the drive.
You can get the exact name to use by running ````systemctl list-units '*.mount'````.

Automounting a drive without Synthing has not been considered, as there has been no other use for automounting yet.
This may be considered and included in the configuration in the future.

### Ludovico

_Ludovico_ is meant to be used as a console, mainly running Steam in Big Picture mode.
To enhance the console experience, a few tweaks were done.

On line 64 of the ````configuration.nix````, an auto login option is declared for a user "ludwig".
This user should also be declared, as in line 89.

Lines 131, 137, and 141 declare options for the Steam session upon login.

You may add some of this configuration to your own if you wish to have a Steam session in your machine.
