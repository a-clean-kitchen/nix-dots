{ config, lib, pkgs, inputs, user, location, ... }:

{
  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" "docker"];
    shell = pkgs.fish;                       # Default shell
  };
  security.sudo.wheelNeedsPassword = false; # User does not need to give password when using sudo.

  time.timeZone = "America/New_York";        # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";	                    # or us/azerty/etc
  };

  security.rtkit.enable = true;
  sound = {                                 # ALSA sound enable
    enable = true;
    mediaKeys = {                           # Keyboard Media Keys (for minimal desktop)
      enable = true;
    };
  };

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

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [           # Default packages install system-wide
      vim
      git
      killall
      nano
      pciutils
      usbutils
      wget
      tldr
    ];
  };

  services = {
    openssh = {                           
      enable = true;                        
    };
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

