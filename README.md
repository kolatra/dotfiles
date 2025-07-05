# dotfiles

My configuration files for my computers at home. :)

They're highly tailored to an individual setup, so they may not work out the box without some changes.

# current setup
- Pandora: Fedora 42
  - AMD R5 5600
  - NVIDIA 4070 SUPER
  - 32GB RAM
  - 2TB NVME SSD
  - 1TB Samsung SSD
- Titan: NixOS 24.11
  - `nix/hosts/server`
  - Intel Core i7-3770
  - 32GB RAM
  - 250GB Samsung SSD
  - 10TB WesternDigital HDD
- Tethys: NixOS 25.11
  - `nix/hosts/laptop`
  - AMD Ryzen 7 8840HS
  - Integrated graphics
  - 16GB RAM
  - 500GB NVME SSD

# services
`Titan` serves as a host for many home services, such as:
  - NGINX
  - Samba File Sharing
  - GregTech: New Horizons server
  - Monifactory server
  - Automated backups with Restic
  - Secure secret handling with Agenix

All devices have Tailscale
