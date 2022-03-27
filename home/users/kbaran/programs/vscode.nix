{ pkgs, lib, ... }:

let
  amazonwebservices.aws-toolkit-vscode = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "aws-toolkit-vscode";
      publisher = "AmazonWebServices";
      version = "1.36.0";
      sha256 = "sha256-6Ylti3x+XZAzE+sb7s7p+nepvqwer+9qbuHlp+1H+UQ=";
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
      amazonwebservices.aws-toolkit-vscode
      bbenoist.nix
      eamodio.gitlens
      golang.go
      hashicorp.terraform
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-vscode-remote.remote-ssh
      redhat.vscode-yaml
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
        "nix.enableLanguageServer" = true;
        "[go]"."editor.tabSize" = 2;
        "vim.useSystemClipboard" = true;
        "json.schemas" = [];
        "yaml.customTags" = [
          "!And"
          "!And sequence"
          "!If"
          "!If sequence"
          "!Not"
          "!Not sequence"
          "!Equals"
          "!Equals sequence"
          "!Or"
          "!Or sequence"
          "!FindInMap"
          "!FindInMap sequence"
          "!Base64"
          "!Join"
          "!Join sequence"
          "!Cidr"
          "!Ref"
          "!Sub"
          "!Sub sequence"
          "!GetAtt"
          "!GetAZs"
          "!ImportValue"
          "!ImportValue sequence"
          "!Select"
          "!Select sequence"
          "!Split"
          "!Split sequence"
        ];
        "aws.profile" = "profile:default";
    };
  };
}
