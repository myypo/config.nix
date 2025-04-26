{
  lib,
  isMainBrowser,
}:
lib.makeBrowser isMainBrowser "firefox.desktop" {
  home.sessionVariables.BROWSER = lib.mkIf isMainBrowser "firefox";

  programs.firefox = {
    enable = true;

    profiles.default = {
      userChrome = ''
              /*================== SIDEBAR ==================*/
        #sidebar-box,
              .sidebar-panel[lwt-sidebar-brighttext] {
                background-color: var(--base_color1) !important;
              }


              /* remove top tabbar */
        #titlebar { visibility: collapse !important; }


              /*================== URL BAR ==================*/
        #urlbar .urlbar-input-box {
                text-align: center !important;
              }


              * {
              font-family: JetBrainsMono Nerd Font Mono !important;
              font-size: 14pt !important;
              }

              /* #nav-bar { visibility: collapse !important; } */
                hide horizontal tabs at the top of the window
                #TabsToolbar > * {
                  visibility: collapse;
                }

                /* hide navigation bar when it is not focused; use Ctrl+L to get focus */
                #main-window:not([customizing]) #navigator-toolbox:not(:focus-within):not(:hover) {
                  margin-top: -45px;
                }
                #navigator-toolbox {
                  transition: 0.2s margin-top ease-out;
                }
      '';
      userContent = ''
                /*hide all scroll bars*/
                /* *{ scrollbar-width: none !important } */


                * {
                    font-family: "Roboto", sans-serif;
                }

                @-moz-document url-prefix("about:") {
                    :root {
                        --in-content-page-background: #1E1E2E !important;
                    }
                }

                @-moz-document url-prefix(about:home), url-prefix(about:newtab){

            body[lwt-newtab-brighttext] {
                --newtab-background-color: #000000 !important;
                --newtab-background-color-secondary: #101010 !important;

            }

            .top-site-outer .top-site-icon {
                background-color: transparent !important;

            }

            .top-site-outer .tile {
                background-color: rgba(49, 49, 49, 0.4) !important;
            }

            .top-sites-list:not(.dnd-active) .top-site-outer:is(.active, :focus, :hover) {
                background: rgba(49, 49, 49, 0.3) !important;
            }

            .top-site-outer .context-menu-button:is(:active, :focus) {
                background-color: transparent !important;
            }

            .search-wrapper .search-handoff-button{
                border-radius: 40px !important;
                background-color: rgba(49, 49, 49, 0.4) !important;
            }
        }
      '';
    };
  };
}
