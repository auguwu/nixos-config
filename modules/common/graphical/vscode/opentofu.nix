{
  opentofu-ls,
  vscode-utils,
  lib,
}:
vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "gamunu";
    name = "opentofu";
    version = "0.2.1";
    hash = "sha256-OizdHTSGuwBRuD/qPXjmna6kZWfRp9EimhcFk3ICN9I=";
  };

  # the extension is just a fork of `terraform-ls` and replaces `terraform`
  # with `opentofu`
  postPatch = ''
    substituteInPlace out/extension.js \
      --replace-fail 'this.customBinPath=(0,u.config)("opentofu").get("languageServer.path")' 'this.customBinPath = this.customBinPath=(0,u.config)("opentofu").get("languageServer.path") || '${opentofu-ls}/bin/opentofu-ls';'
  '';

  meta = {
    changelog = "https://marketplace.visualstudio.com/items/gamunu.opentofu/changelog";
    description = "Syntax highlighting and autocompletion for OpenTofu";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=gamunu.opentofu";
    homepage = "https://github.com/gamunu/vscode-opentofu";
    license = lib.licenses.mpl20;
    maintainers = [lib.maintainers.auguwu];
  };
}
