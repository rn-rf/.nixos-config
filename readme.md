# ❄️ Utopia: NixOS + Hyprland Configuration

A modular, flake-based NixOS configuration focused on:

* reproducibility
* minimalism
* Wayland-first workflow
* Hyprland customization
* portable dotfiles

---

##  Setup

Clone the repository into your home directory:

```bash
git clone <repo-url> ~/.nixos-config
cd ~/.nixos-config
```

Apply the configuration:

```bash
sudo nixos-rebuild switch --flake ~/.nixos-config#Utopia
```

This will:

* install all required system packages
* configure the desktop environment
* link dotfiles into their correct locations
* set up the complete user environment

---

###  Updating the system

After making changes, rebuild with:

```bash
sudo nixos-rebuild switch --flake ~/.nixos-config#Utopia
```

or use the alias:

```bash
utopia
```

Your system will update automatically with the new configuration.

---

##  Overview

This repository contains the complete system and user environment configuration for my NixOS setup.

It uses:

* **Nix flakes** for reproducibility
* **Home Manager** for user environment management
* **Hyprland** as the primary Wayland compositor
* **Waybar** for status bar
* **Modular configuration structure** for maintainability

---

##  Architecture

```
.nixos-config/
├── flake.nix              # flake entrypoint
├── hosts/                 # host-specific configuration
├── modules/               # reusable system modules
├── home/                  # Home Manager configuration
└── dotfiles/              # user config & UI customization
```

---

##  System Features

###  Core

* Flake-based NixOS configuration
* Modular system layout
* GRUB dual-boot support
* PipeWire audio
* NetworkManager

###  Desktop

* Hyprland (Wayland compositor)
* GNOME fallback session
* Flatpak support

###  UI & Workflow

* Waybar with modular scripts
* Dynamic transparency system
* Pywal theming support
* Ghostty terminal
* Custom GTK + icon themes

###  Development Environment

* Node.js & TypeScript tooling
* Java LSP (jdtls)
* GCC & JDK
* Git + tmux workflow

---

##  Home Manager

Home Manager manages:

* Hyprland configuration
* Waybar configuration
* Ghostty terminal
* tmux configuration
* shell environment
* user scripts

Config files are stored in:

```
dotfiles/
```

and symlinked into:

```
~/.config
```

This ensures reproducibility and version control.

---

##  Hyprland

Hyprland configuration is stored in:

```
dotfiles/hypr/
```

Changes can be applied instantly:

```
hyprctl reload
```

Runtime changes should use `hyprctl` instead of modifying config files.

---

##  TODO

### Waybar & UI

* [ ] Integrate `Toggal` with cache state (change transperancy of waybar dynamically) 
* [ ] Add multi-monitor awareness


### System Improvements

* [ ] Neovim setup (nixvim/nixcats)
* [ ] add secrets management (agenix/sops)
* [ ] power management tuning
* [ ] gaming support profile
* [ ] laptop battery optimization

### Dev Environment

* [ ] devshell configuration
* [ ] language-specific profiles

---

##  License

Personal configuration. Use freely for inspiration.


**System Name:** Utopia
**User:** rn
**OS:** NixOS (flake-based)
**Compositor:** Hyprland
