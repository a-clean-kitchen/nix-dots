{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = [ pkgs.vscodium ];
    extensions = [ pkgs.vscode-extensions.catppuccin.catppuccin-vsc pkgs.vscode-extensions.github.copilot ];
    userSettings = {
      "customizeUI.stylesheet" = {
        ".decorationsOverviewRuler" = "display: none;";
        ".editor-group-container .title *" = "display: none;";
        ".editor-group-container .title" = "pointer-events: none;";
        ".editor-group-container.empty" = "-webkit-app-region: drag;";
        ".monaco-editor .scroll-decoration" = "box-shadow: none;";
      };
      "customizeUI.titleBar" = "inline";
      "debug.console.fontFamily" = "FiraCode Mono";
      "debug.console.fontSize" = 15;
      "debug.console.lineHeight" = 36;
      "debug.toolBarLocation" = "docked";
      "diffEditor.ignoreTrimWhitespace" = false;
      "diffEditor.renderSideBySide" = false;
      "editor.bracketPairColorization.enabled" = false;
      "editor.colorDecorators" = false;
      "editor.cursorStyle" = "line-thin";
      "editor.fontFamily" = "FiraCode Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 15;
      "editor.formatOnSave" = true;
      "editor.glyphMargin" = false;
      "editor.gotoLocation.multipleDeclarations" = "goto";
      "editor.gotoLocation.multipleDefinitions" = "goto";
      "editor.gotoLocation.multipleImplementations" = "goto";
      "editor.gotoLocation.multipleReferences" = "goto";
      "editor.gotoLocation.multipleTypeDefinitions" = "goto";
      "editor.guides.indentation" = false;
      "editor.hideCursorInOverviewRuler" = true;
      "editor.lineHeight" = 36;
      "editor.lineNumbers" = "off";
      "editor.matchBrackets" = "near";
      "editor.minimap.enabled" = false;
      "editor.occurrencesHighlight" = false;
      "editor.renderLineHighlight" = "none";
      "editor.renderWhitespace" = "none";
      "editor.scrollbar.horizontalScrollbarSize" = 8;
      "editor.scrollbar.verticalScrollbarSize" = 8;
      "explorer.compactFolders" = false;
      "explorer.decorations.badges" = false;
      "explorer.openEditors.visible" = 0;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "markdown.preview.markEditorSelection" = false;
      "problems.decorations.enabled" = false;
      "scm.diffDecorations" = "none";
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "terminal.integrated.fontSize" = 15;
      "terminal.integrated.lineHeight" = 1.85;
      "window.autoDetectColorScheme" = true;
      "window.newWindowDimensions" = "inherit";
      "window.title" = "\${rootName}";
      "window.titleBarStyle" = "custom";
      "workbench.activityBar.visible" = false;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.revealIfOpen" = true;
      "workbench.editor.showTabs" = false;
      "workbench.editor.untitled.hint" = "hidden";
      "workbench.iconTheme" = null;
      "workbench.list.horizontalScrolling" = true;
      "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
      "workbench.preferredLightColorTheme" = "Catppuccin Latte";
      "workbench.startupEditor" = "none";
      "workbench.statusBar.visible" = false;
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 16;
      "workbench.tree.renderIndentGuides" = "none";
    };
  };
}

