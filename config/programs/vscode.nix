{ pkgs, lib, ... }:

let
  arcticicestudio.nord-visual-studio-code = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nord-visual-studio-code";
      publisher = "arcticicestudio";
      version = "0.15.1";
      sha256 = "0lc50jkwxq3vffpwlkqdnkq77c7gbpfn1lk9l0n9qxsyfyhb68qj";
    };
    meta = {
      license = lib.licenses.mit;
    };
  };
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      bbenoist.Nix
      golang.Go
      hashicorp.terraform
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      vscodevim.vim
    ];
    keybindings = [
      {
        key = "ctrl+k";
        command = "selectPrevSuggestion";
        when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
        key = "ctrl+j";
        command = "selectNextSuggestion";
        when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.navigateLeft";
        when = "!suggestWidgetVisible";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.navigateRight";
        when = "!suggestWidgetVisible";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.navigateUp";
        when = "!suggestWidgetVisible";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.navigateDown";
        when = "!suggestWidgetVisible";
      }
    ];
    userSettings = {
        "workbench.colorTheme" = "Nord";
        "window.menuBarVisibility" = "toggle";
        "workbench.tree.indent" = 16;
        "[nix]"."editor.tabSize" = 2;
        "[go]"."editor.tabSize" = 2;
        "vim.useSystemClipboard" = true;
    };
  };
}
