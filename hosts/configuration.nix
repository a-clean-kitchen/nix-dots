#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./editors
#       │   └─ ./emacs
#       │      └─ native.nix
#       └─ ./shell
#           └─ ./default.nix
#

{ config, lib, pkgs, inputs, user, location, ... }:

{
  # imports =
  #   [(import ../modules/editors/emacs/native.nix)] ++  # Native doom emacs instead of nix-community flake
  #   ( import ../modules/shell );
  
  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" ];
    shell = pkgs.fish;
    # ofc ofc change me
    initialPassword = "P4ssword!";
  };
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    dhcpcd.enable = true;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;
  
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  programs.hyprland.enable = true;
  xdg.portal.wlr.enable = true;

  environment = {
    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
      DISPLAY=":1";
    };
    systemPackages = with pkgs; [           # Default packages installed system-wide
      vim tmux nano
      git jq thefuck tldr
      killall gh
      pciutils usbutils
      dig nmap curl traceroute wget                           # Network tools
      xdg-utils ly
      ranger tree
    ];
  };

#####################
  # puts systemd init logs on tty1
  # so that tuigreet and systemd logs don't clobber each other
  boot.kernelParams = [
    "console=tty1"
  ];

  # TODO: unlock gnome-keyring
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --asterisks --cmd Hyprland";
        user = user;
      };
      default_session = initial_session;
    };    };
  };
######################
  services = {
    printing = {                                # Printing and drivers for TS5300
      enable = true;
    };
    avahi = {                                   # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = {                               # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {                             # SSH: secure shell (remote connection to shell of server)
      enable = true;                        # local: $ ssh <user>@<ip>
    };
  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}

