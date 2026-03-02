# ❄️ Utopia — NixOS + Hyprland Configuration

A modular, flake-based NixOS configuration focused on:

* reproducibility
* minimalism
* Wayland-first workflow
* Hyprland customization
* portable dotfiles
* developer productivity

---

## 🧭 Overview

This repository contains the complete system and user environment configuration for my NixOS setup.

It uses:

* **Nix flakes** for reproducibility
* **Home Manager** for user environment management
* **Hyprland** as the primary Wayland compositor
* **Waybar** for status bar and UI modules
* **Modular configuration structure** for maintainability

---

## 🧱 Architecture

```
.nixos-config/
├── flake.nix              # flake entrypoint
├── hosts/                 # host-specific configuration
├── modules/               # reusable system modules
├── home/                  # Home Manager configuration
└── dotfiles/              # user config & UI customization
```

---

## 🖥 System Features

### ✔ Core

* Flake-based NixOS configuration
* Modular system layout
* GRUB dual-boot support
* PipeWire audio
* NetworkManager

### ✔ Desktop

* Hyprland (Wayland compositor)
* GNOME fallback session
* Flatpak support

### ✔ UI & Workflow

* Waybar with modular scripts
* Dynamic transparency system
* Pywal theming support
* Ghostty terminal
* Custom GTK + icon themes

### ✔ Development Environment

* Node.js & TypeScript tooling
* Java LSP (jdtls)
* GCC & JDK
* Git + tmux workflow

---

## 🏠 Home Manager

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

## 🪟 Hyprland

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

## 📊 Waybar

Waybar configuration lives in:

```
dotfiles/waybar/
```

### Features

* theme system
* dynamic transparency
* modular scripts
* window state detection
* custom modules

Scripts live in:

```
dotfiles/waybar/scripts/
```

---

## 🎨 Dynamic Transparency System

A script (`one_window.sh` / `toggal`) dynamically changes Waybar transparency based on window count.

### Design

Immutable configuration:

```
~/.config/waybar
```

Runtime state:

```
~/.cache/waybar
```

This follows XDG standards and NixOS immutability principles.

---

## 🔁 Rebuild System

Alias:

```
rebuild
```

Runs:

```
sudo nixos-rebuild switch --flake ~/.nixos-config#Utopia
```

---

## 🚀 Installation / Rebuild

### Rebuild system

```
sudo nixos-rebuild switch --flake ~/.nixos-config#Utopia
```

### Home Manager

```
home-manager switch
```

---

## 📂 Dotfiles Philosophy

This setup separates:

### Declarative (Git-tracked)

* Hyprland config
* Waybar layout & themes
* terminal configuration

### Runtime state

* dynamic CSS
* toggle state
* temporary files

This ensures reproducibility and stability.

---

## ⚠️ Known Issues

### Waybar Transparency Toggle

* `toggal` script currently attempts to write to immutable config paths.
* Must use:

```
~/.cache/waybar/
```

instead of:

```
~/.config/waybar/
```

### Window State Module

* `window_checker.sh` needs migration to runtime cache.
* Module integration with Waybar pending.

---

## 🛠 TODO

### Waybar & UI

* [ ] Fix `toggal` runtime cache usage
* [ ] Integrate `window_checker.sh` with cache state
* [ ] Improve transparency transitions
* [ ] Add multi-monitor awareness
* [ ] Optimize Waybar reload (signal vs restart)

### Hyprland

* [ ] Add runtime toggles using `hyprctl`
* [ ] Gap & border toggle script
* [ ] animation presets

### System Improvements

* [ ] declarative Neovim setup (nixvim)
* [ ] add secrets management (agenix/sops)
* [ ] power management tuning
* [ ] gaming support profile
* [ ] laptop battery optimization

### Dev Environment

* [ ] devshell configuration
* [ ] language-specific profiles
* [ ] docker/podman module

---

## 🧠 Future Enhancements

* multi-host support
* CI build validation
* remote rebuild support
* theming automation
* system profile switching

---

## 📜 License

Personal configuration. Use freely for inspiration.

---

## 🙌 Credits

Inspired by the NixOS & Hyprland communities.

---

**System Name:** Utopia
**User:** rn
**OS:** NixOS (flake-based)
**Compositor:** Hyprland
**Philosophy:** Reproducible, minimal, and fast.
