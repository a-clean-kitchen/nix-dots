{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = ''
      if status is-interactive
          # Commands to run in interactive sessions can go here
        starship init fish | source &
        thefuck --alias | source &
        ~/.config/fish/tty.sh &
      end


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
      set -g __fish_git_prompt_char_upstream_prefix ''''


      set -g man_blink -o $teal
      set -g man_bold -o $pink
      set -g man_standout -b $gray
      set -g man_underline -u $blue


      # Directory abbreviations
      abbr -a -g l 'ls'
      abbr -a -g la 'ls -a'
      abbr -a -g ll 'ls -l'
      abbr -a -g lal 'ls -al'
      abbr -a -g d 'dirs'
      abbr -a -g h 'cd $HOME'

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


      # User abbreviations
      abbr -a -g ytmp3 'youtube-dl --extract-audio --audio-format mp3'				# Convert/Download YT videos as mp3
      abbr -a -g cls 'clear'# Clear
      abbr -a -g h 'history'# Show history
      abbr -a -g upd 'paru -Syu --noconfirm'# Update everything
      abbr -a -g please 'sudo'# Polite way to sudo
      abbr -a -g fucking 'sudo'# Rude way to sudo
      abbr -a -g sayonara 'shutdown now'# Epic way to shutdown
      abbr -a -g shinei 'kill -9'# Kill ala DIO
      abbr -a -g priv 'fish --private'# Fish incognito mode
      abbr -a -g sshon 'sudo systemctl start sshd.service'# Start ssh service
      abbr -a -g sshoff 'sudo systemctl stop sshd.service'# Stop ssh service
      abbr -a -g untar 'tar -zxvf'# Untar
      abbr -a -g genpass 'openssl rand -base64 20'# Generate a random, 20-charactered password
      abbr -a -g sha 'shasum -a 256'# Test checksum
      abbr -a -g cn 'ping -c 5 8.8.8.8'# Ping google, checking network
      abbr -a -g ipe 'curl ifconfig.co'# Get external IP address
      abbr -a -g ips 'ip link show'# Get network interfaces information
      abbr -a -g wloff 'rfkill block wlan'# Block wlan, killing wifi connection
      abbr -a -g wlon 'rfkill unblock wlan'# Unblock wlan, start wifi connection

      # Source plugins
      # Useful plugins: archlinux bang-bang cd colorman sudope vcs
      # if test -d "$HOME/.local/share/omf/pkg/colorman/"
      # 	source ~/.local/share/omf/pkg/colorman/init.fish
      # end

      # Make su launch fish
      function su
        command su --shell=/usr/bin/fish $argv
      end

      # function wa
      #     set -f APPID "6HV6YJ-QGK36VKQQJ" # Get one at https://products.wolframalpha.com/api/
      #     echo $argv | string escape --style=url | read question_string
      #     set -f url "https://api.wolframalpha.com/v1/result?appid="$APPID"&i="$question_string
      #     curl -s $url
      # end

      # Get terminal emulator
      # set TERM_EMULATOR (ps -aux | grep (ps -p $fish_pid -o ppid=) | awk 'NR==1{print $11}')

      # Neofetch
      # switch "$TERM_EMULATOR"
      # case '*kitty*'
      #       neofetch --backend 'kitty'
      # case '*tmux*' '*login*' '*sshd*' '*konsole*'
      #	neofetch --backend 'ascii' --ascii_distro 'arch_small' 
      # case '*'
      # 	neofetch --backend 'w3m' --xoffset 34 --yoffset 34 --gap 0
      # end


      alias bat='bat --theme="Catppuccin-mocha"'
      alias hc=herbstclient
      alias code='code-insiders'
      set MOZ_ENABLE_WAYLAND 1
      set XDG_CURRENT_DESKTOP sway
    '';
    plugins = [
      {
        name = "decors/fish-colored-man";
        src = pkgs.fetchFromGithub {
          owner = "decors";
          repo = "fish-colored-man";
          rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
          sha256 = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
        };
      }

      {
        name = "catpuccin/fish";
        src = pkgs.fetchFromGithub {
          owner = "catpuccin";
          repo = "fish";
          rev = "b90966686068b5ebc9f80e5b90fdf8c02ee7a0ba";
          sha256 = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
        };
      }
    ];
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
  xdg.configFile."fish/functions" = {
    recursive = true;
    source = ./functions;
  };
  xdg.configFile."fish/config.fish".source = ./config.fish;
  xdg.configFile."fish/fish_variables".source = ./fish_variables;
  xdg.configFile."fish/fish_plugins".source = ./fish_plugins;
  xdg.configFile."fish/tty.sh" = {
    source = ./tty.sh;
    executable = true;
  };
}