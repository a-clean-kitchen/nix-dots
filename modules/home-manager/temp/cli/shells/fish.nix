{ 
  lib,
  pkgs,
  config,
  ...
}:

with lib;

let

  cfg = config.modules.cli.shells.fish;

  pluginModule = types.submodule ({ config, ... }: {
    options = {
      src = mkOption {
        type = types.path;
        description = ''
          Path to the plugin folder.
          </para><para>
          Relevant pieces will be added to the fish function path and
          the completion path. The <filename>init.fish</filename> and
          <filename>key_binding.fish</filename> files are sourced if
          they exist.
        '';
      };

      name = mkOption {
        type = types.str;
        description = ''
          The name of the plugin.
        '';
      };
    };
  });

  functionModule = types.submodule {
    options = {
      body = mkOption {
        type = types.lines;
        description = ''
          The function body.
        '';
      };

      argumentNames = mkOption {
        type = with types; nullOr (either str (listOf str));
        default = null;
        description = ''
          Assigns the value of successive command line arguments to the names
          given.
        '';
      };

      description = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          A description of what the function does, suitable as a completion
          description.
        '';
      };

      wraps = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Causes the function to inherit completions from the given wrapped
          command.
        '';
      };

      onEvent = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Tells fish to run this function when the specified named event is
          emitted. Fish internally generates named events e.g. when showing the
          prompt.
        '';
      };

      onVariable = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Tells fish to run this function when the specified variable changes
          value.
        '';
      };

      onJobExit = mkOption {
        type = with types; nullOr (either str int);
        default = null;
        description = ''
          Tells fish to run this function when the job with the specified group
          ID exits. Instead of a PID, the stringer <literal>caller</literal> can
          be specified. This is only legal when in a command substitution, and
          will result in the handler being triggered by the exit of the job
          which created this command substitution.
        '';
      };

      onProcessExit = mkOption {
        type = with types; nullOr (either str int);
        default = null;
        example = "$fish_pid";
        description = ''
          Tells fish to run this function when the fish child process with the
          specified process ID exits. Instead of a PID, for backwards
          compatibility, <literal>%self</literal> can be specified as an alias
          for <literal>$fish_pid</literal>, and the function will be run when
          the current fish instance exits.
        '';
      };

      onSignal = mkOption {
        type = with types; nullOr (either str int);
        default = null;
        example = [ "SIGHUP" "HUP" 1 ];
        description = ''
          Tells fish to run this function when the specified signal is
          delievered. The signal can be a signal number or signal name.
        '';
      };

      noScopeShadowing = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Allows the function to access the variables of calling functions.
        '';
      };

      inheritVariable = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Snapshots the value of the specified variable and defines a local
          variable with that same name and value when the function is defined.
        '';
      };
    };
  };

  abbrsStr = concatStringsSep "\n"
    (mapAttrsToList (k: v: "abbr --add --global -- ${k} ${escapeShellArg v}")
      cfg.shellAbbrs);

  aliasesStr = concatStringsSep "\n"
    (mapAttrsToList (k: v: "alias ${k} ${escapeShellArg v}") cfg.shellAliases);

  fishIndent = name: text:
    pkgs.runCommand name {
      nativeBuildInputs = [ cfg.package ];
      inherit text;
      passAsFile = [ "text" ];
    } "env HOME=$(mktemp -d) fish_indent < $textPath > $out";

in {
  imports = [
    (mkRemovedOptionModule [ "programs" "fish" "promptInit" ] ''
      Prompt is now configured through the

        programs.fish.interactiveShellInit

      option. Please change to use that instead.
    '')
  ];

  options = {
    modules.cli.shells.fish = {
      enable = mkEnableOption "fish, the friendly interactive shell";

      package = mkOption {
        type = types.package;
        default = pkgs.fish;
        defaultText = literalExpression "pkgs.fish";
        description = ''
          The fish package to install. May be used to change the version.
        '';
      };

      shellAliases = mkOption {
        type = with types; attrsOf str;
        default = { };
        example = literalExpression ''
          {
            g = "git";
            "..." = "cd ../..";
          }
        '';
        description = ''
          An attribute set that maps aliases (the top level attribute names
          in this option) to command strings or directly to build outputs.
        '';
      };

      shellAbbrs = mkOption {
        type = with types; attrsOf str;
        default = { };
        example = {
          l = "less";
          gco = "git checkout";
        };
        description = ''
          An attribute set that maps aliases (the top level attribute names
          in this option) to abbreviations. Abbreviations are expanded with
          the longer phrase after they are entered.
        '';
      };

      shellInit = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Shell script code called during fish shell
          initialisation.
        '';
      };

      loginShellInit = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Shell script code called during fish login shell
          initialisation.
        '';
      };

      interactiveShellInit = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Shell script code called during interactive fish shell
          initialisation.
        '';
      };
    };

    programs.fish.plugins = mkOption {
      type = types.listOf pluginModule;
      default = [ ];
      description = ''
        The plugins to source in
        <filename>conf.d/99plugins.fish</filename>.
      '';
    };

    programs.fish.functions = mkOption {
      type = with types; attrsOf (either lines functionModule);
      default = { };
      description = ''
        Basic functions to add to fish. For more information see
        <link xlink:href="https://fishshell.com/docs/current/cmds/function.html"/>.
      '';
    };
  };

  config = mkIf cfg.enable{

    };
}