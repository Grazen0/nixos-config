{config, ...}: let
  inherit (config) theme;
  colors = theme.colors.hexWithHashtag;
in
  # css
  ''
    /**
     * @name system24
     * @description A tui-style discord theme. * @author refact0r
     * @version 1.0.0
     * @invite nz87hXyvcy
     * @website https://github.com/refact0r/system24
     * @source https://github.com/refact0r/system24/blob/master/system24.theme.css
     * @authorId 508863359777505290
     * @authorLink https://www.refact0r.dev
    */

    @import url("https://refact0r.github.io/system24/src/main.css");
    @import url("https://refact0r.github.io/system24/src/unrounding.css");

    :root {
      --font: "${theme.font.regular}";
      letter-spacing: -0.1ch;
      font-weight: 300;
      --label-font-weight: 500; /* font weight for panel labels. */
      --pad: 12px; /* padding between panels. */
      --txt-pad: 10px; /* padding inside panels to prevent labels from clipping */
      --panel-roundness: 0px; /* corner roundness of panels. */

      /* background colors */
      --bg-0: ${colors.background}; /* main background color. */
      --bg-1: ${colors.black}; /* background color for secondary elements like code blocks, embeds, etc. */
      --bg-2: ${colors.background}; /* color of neutral buttons. */
      --bg-3: ${colors.backgroundAlt}; /* color of neutral buttons when hovered. */

      /* state modifiers */
      --hover: oklch(54% 0 0 / 0.1); /* color of hovered elements. */
      --active: oklch(54% 0 0 / 0.2); /* color of elements when clicked. */
      --selected: var(--active); /* color of selected elements. */

      /* text colors */
      --txt-dark: var(--bg-0); /* color of dark text on colored backgrounds. */
      --txt-link: ${colors.brightBlue}; /* color of links. */
      --txt-0: ${colors.brightWhite}; /* color of bright/white text. */
      --txt-1: ${colors.foreground}; /* main text color. */
      --txt-2: ${colors.white}; /* color of secondary text like channel list. */
      --txt-3: ${colors.brightBlack}; /* color of muted text. */

      /* accent colors */
      --acc-0: ${colors.blue}; /* main accent color. */
      --acc-1: ${colors.blue}; /* color of accent buttons when hovered. */
      --acc-2: var(--acc-1); /* color of accent buttons when clicked. */

      /* borders */
      --border-width: 2px; /* panel border thickness. */
      --border-color: var(--bg-3); /* panel border color. */
      --border-hover-color: var(--acc-0); /* panel border color when hovered. */
      --border-transition: none; /* panel border transition. */

      /* status dot colors */
      --online-dot: ${colors.green}; /* color of online dot. */
      --dnd-dot: ${colors.red}; /* color of do not disturb dot. */
      --idle-dot: ${colors.yellow}; /* color of idle dot. */
      --streaming-dot: ${colors.magenta}; /* color of streaming dot. */

      /* mention/ping and message colors */
      --mention-txt: var(--acc-0); /* color of mention text. */
      /* background highlight of mention text. */
      --mention-bg: color-mix(in oklch, var(--acc-0), transparent 90%);
      /* overlay color of messages that mention you. */
      --mention-overlay: color-mix(in oklch, var(--acc-0), transparent 90%);
      /* overlay color of messages that mention you when hovered. */
      --mention-hover-overlay: color-mix(in oklch, var(--acc-0), transparent 95%);
      /* overlay color of message you are replying to. */
      --reply-overlay: var(--active);
      /* overlay color of message you are replying to when hovered. */
      --reply-hover-overlay: var(--hover);
    }
  ''
