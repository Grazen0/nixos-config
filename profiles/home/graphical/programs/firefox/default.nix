{pkgs, ...}: {
  # Credit: https://github.com/c1d3r24/dotfiles-config/blob/main/home/common/firefox.nix
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    languagePacks = [
      "es-ES"
      "es-AR"
      "es-MX"
    ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;

      TranslateEnabled = false;

      ExtensionSettings = let
        mkExtension = name: extraConfig:
          {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
            installation_mode = "force_installed";
          }
          // extraConfig;
      in {
        "uBlock0@raymondhill.net" = mkExtension "ublock-origin" {private_browsing = true;};
        "private-relay@firefox.com" = mkExtension "private-relay" {};
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = mkExtension "vimium-ff" {private_browsing = true;};
        "addon@darkreader.org" = mkExtension "darkreader" {private_browsing = true;};
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = mkExtension "return-youtube-dislikes" {};
        "jid1-MnnxcxisBPnSXQ@jetpack" = mkExtension "privacy-badger17" {private_browsing = true;};
        "CanvasBlocker@kkapsner.de" = mkExtension "canvasblocker" {private_browsing = true;};
        "custom-new-tab-page@mint.as" = mkExtension "custom-new-tab-page" {};
      };
    };

    profiles.default = {
      search.default = "ddg";

      settings = {
        "privacy.trackingprotection.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;

        "sidebar.visibility" = "always-show";
        "sidebar.main.tools" = "history";
        "sidebar.verticalTabs" = true;

        "network.dns.disablePrefetch" = false;

        "findbar.highlightAll" = true;

        "middlemouse.paste" = false;

        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.aboutConfig.showWarning" = false;
        "browser.quitShortcut.disabled" = true;

        "browser.uiCustomization.state" =
          # json
          ''
            {
              "placements": {
                "widget-overflow-fixed-list": [],
                "unified-extensions-area": [
                  "jid1-mnnxcxisbpnsxq_jetpack-browser-action",
                  "private-relay_firefox_com-browser-action",
                  "ublock0_raymondhill_net-browser-action",
                  "canvasblocker_kkapsner_de-browser-action",
                  "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
                ],
                "nav-bar": [
                  "sidebar-button",
                  "back-button",
                  "forward-button",
                  "stop-reload-button",
                  "customizableui-special-spring3",
                  "urlbar-container",
                  "vertical-spacer",
                  "customizableui-special-spring4",
                  "downloads-button",
                  "unified-extensions-button",
                  "addon_darkreader_org-browser-action",
                  "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
                ],
                "toolbar-menubar": ["menubar-items"],
                "TabsToolbar": [],
                "vertical-tabs": ["tabbrowser-tabs"],
                "PersonalToolbar": ["personal-bookmarks"]
              },
              "seen": [
                "canvasblocker_kkapsner_de-browser-action",
                "addon_darkreader_org-browser-action",
                "jid1-mnnxcxisbpnsxq_jetpack-browser-action",
                "private-relay_firefox_com-browser-action",
                "ublock0_raymondhill_net-browser-action",
                "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action",
                "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action",
                "developer-button"
              ],
              "dirtyAreaCache": [
                "unified-extensions-area",
                "nav-bar",
                "TabsToolbar",
                "vertical-tabs",
                "toolbar-menubar",
                "PersonalToolbar"
              ],
              "currentVersion": 21,
              "newElementCount": 6
            }
          '';
      };

      bookmarks = import ./bookmarks.nix;
    };
  };
}
