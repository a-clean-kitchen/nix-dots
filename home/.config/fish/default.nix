{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # starship init fish | source &
      thefuck --alias | source &
      ~/.config/fish/tty.sh &
    '';
    shellInit = ''
      set -l teal 94e2d5
      set -l flamingo f2cdcd
      set -l mauve cba6f7
      set -l pink f5c2e7
      set -l red f38ba8
      set -l peach fab387
      set -l green a6e3a1
      set -l yellow f9e2af
      set -l blue 89b4fa
      set -l gray 1f1d2e
      set -l black 191724
          
      # Completion Pager Colors
      set -g fish_pager_color_progress $gray
      set -g fish_pager_color_prefix $mauve
      set -g fish_pager_color_completion $peach
      set -g fish_pager_color_description $gray

      # Some config
      set -g fish_greeting

      # Git config
      set -g __fish_git_prompt_show_informative_status 1
      set -g __fish_git_prompt_showupstream informative
      set -g __fish_git_prompt_showdirtystate yes
      set -g __fish_git_prompt_char_stateseparator ' '
      set -g __fish_git_prompt_char_cleanstate '✔'
      set -g __fish_git_prompt_char_dirtystate '✚'
      set -g __fish_git_prompt_char_invalidstate '✖'
      set -g __fish_git_prompt_char_stagedstate '●'
      set -g __fish_git_prompt_char_stashstate '⚑'
      set -g __fish_git_prompt_char_untrackedfiles '?'
      set -g __fish_git_prompt_char_upstream_ahead ''
      set -g __fish_git_prompt_char_upstream_behind ''
      set -g __fish_git_prompt_char_upstream_diverged 'ﱟ'
      set -g __fish_git_prompt_char_upstream_equal ''


      set -g man_blink -o $teal
      set -g man_bold -o $pink
      set -g man_standout -b $gray
      set -g man_underline -u $blue

      # Locale
      export LANG="en_US.UTF-8"
      export LC_ALL="en_US.UTF-8"

      # Exports
      export VISUAL="vim"
      export EDITOR="$VISUAL"

      # Term
      switch "$TERM_EMULATOR"
      case '*kitty*'
        export TERM='xterm-kitty'
      case '*'
        export TERM='xterm-256color'
      end

      # Make su launch fish
      function su
        command su --shell=/usr/bin/fish $argv
      end

      set MOZ_ENABLE_WAYLAND 1
      set XDG_CURRENT_DESKTOP sway
    '';
    shellAbbrs = {
      cls = "clear";
      hl = "history | less";
      please = "sudo";# Polite way to sudo
      fucking = "sudo";# Less polite way to sudo
      sayonara = "shutdown now";# Epic way to shutdown
      shinei = "kill -9";# Kill ala DIO
      priv = "fish --private";# XXXASCII
      untar = "tar -zxvf";
      genpass = "openssl rand -base64 20"; # Generate a random, 20-charactered password
      sha = "shasum -a 256";# Test checksum
      cn = "ping -c 5 8.8.8.8";# Ping google, checking network
      ipe = "curl ifconfig.co";# Get external IP address
      ips = "ip link show";# Get network interfaces information
      wloff = "rfkill block wlan";# Block wlan, killing wifi connection
      wlon = "rfkill unblock wlan";# Unblock wlan, start wifi connection

      l = "ls";
      la = "ls -a";
      ll = "ls -l";
      lal = "ls -al";
      d = "dirs";
      h = "cd $HOME";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
    functions = {
      "man" = {
        wraps = "man";
        description = "Format and display manual pages";
        body = ''
          set -q man_blink; and set -l blink (set_color $man_blink); or set -l blink (set_color -o red)
          set -q man_bold; and set -l bold (set_color $man_bold); or set -l bold (set_color -o 5fafd7)
          set -q man_standout; and set -l standout (set_color $man_standout); or set -l standout (set_color 949494)
          set -q man_underline; and set -l underline (set_color $man_underline); or set -l underline (set_color -u afafd7)

          set -l end (printf "\e[0m")

          set -lx LESS_TERMCAP_mb $blink
          set -lx LESS_TERMCAP_md $bold
          set -lx LESS_TERMCAP_me $end
          set -lx LESS_TERMCAP_so $standout
          set -lx LESS_TERMCAP_se $end
          set -lx LESS_TERMCAP_us $underline
          set -lx LESS_TERMCAP_ue $end
          set -lx LESS '-R -s'

          set -lx GROFF_NO_SGR yes # fedora

          set -lx MANPATH (string join : $MANPATH)
          if test -z "$MANPATH"
              type -q manpath
              and set MANPATH (command manpath)
          end

          # Check data dir for Fish 2.x compatibility
          set -l fish_data_dir
          if set -q __fish_data_dir
              set fish_data_dir $__fish_data_dir
          else
              set fish_data_dir $__fish_datadir
          end

          set -l fish_manpath (dirname $fish_data_dir)/fish/man
          if test -d "$fish_manpath" -a -n "$MANPATH"
              set MANPATH "$fish_manpath":$MANPATH
              command man $argv
              return
          end
          command man $argv
        '';
      };
    };
  };
  xdg.configFile."fish/conf.d" = {
    recursive = true;
    source = ./conf.d;
  };
  xdg.configFile."fish/fish_variables".source = ./fish_variables;
  xdg.configFile."fish/tty.sh" = {
    source = ./tty.sh;
    executable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}