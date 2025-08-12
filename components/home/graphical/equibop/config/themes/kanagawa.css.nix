{ config, ... }:
with config.scheme.withHashtag;
# css
''
  /**
   * @name midnight
   * @description a dark, customizable discord theme.
   * @author refact0r
   * @version 2.0.1
   * @invite nz87hXyvcy
   * @website https://github.com/refact0r/midnight-discord
   * @source https://github.com/refact0r/midnight-discord/blob/master/themes/midnight.theme.css
   * @authorId 508863359777505290
   * @authorLink https://www.refact0r.dev
  */

  /* import theme modules */
  @import url('https://refact0r.github.io/midnight-discord/build/midnight.css');

  body {
      /* sizes */
      --gap: 6px;
      --divider-thickness: 2px;

      /* animation/transition options */
      --animations: off;
      --list-item-transition: 0.2s ease;
      --dms-icon-svg-transition: 0.4s ease;

      /* top bar options */
      --move-top-bar-buttons: off;
      --custom-app-top-bar-height: 28px;

      /* window controls */
      --custom-window-controls: on;
      --window-control-size: 14px;

      /* dms button icon options */
      --dms-icon: default;
      --dms-icon-svg-url: url('https://upload.wikimedia.org/wikipedia/commons/c/c4/Font_Awesome_5_solid_moon.svg');
      --dms-icon-svg-size: 90%;
      --dms-icon-color-before: var(--icon-secondary);
      --dms-icon-color-after: var(--white);

      /* dms button background options */
      --dms-background: off;
      --dms-background-image-url: url("");
      --dms-background-image-size: cover;
      --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2));

      /* background image options */
      --background-image: off;
      --background-image-url: url("");

      /* transparency/blur options */
      --transparency-tweaks: off;
      --remove-bg-layer: off;
      --panel-blur: off;
      --blur-amount: 12px;
      --bg-floating: var(--bg-3);

      /* chatbar options */
      --flipped-chatbar: on;
      --chatbar-height: 47px;
      --chatbar-padding: 4px;

      /* other options */
      --small-user-panel: off;
  }

  /* color options */
  :root {
      --colors: on;

      /* border radiuses */
      --radius-sm: 0;
      --radius-md: 0;
      --radius-lg: 0;

      /* text colors */
      --text-0: var(--bg-4); /* text on colored elements */
      --text-1: ${base05}; /* other normally white text */
      --text-2: ${base05}; /* headings and important text */
      --text-3: ${base05}; /* normal text */
      --text-4: ${base06}; /* icon buttons and channels */
      --text-5: ${base04}; /* muted channels/chats and timestamps */

      /* background and dark colors */
      --bg-1: ${base03}; /* dark buttons when clicked */
      --bg-2: ${base01}; /* dark buttons */
      --bg-3: ${base01}; /* spacing, secondary elements */
      --bg-4: ${base00}; /* main background color */
      --hover: ${base03}; /* channels and buttons when hovered */
      --active: ${base03}; /* channels and buttons when clicked or selected */
      --active-2: ${base02}; /* extra state for transparent buttons */
      --message-hover: color-mix(in srgb, var(--bg-4), 4% ${base05}); /* messages when hovered */

      /* accent colors */
      --accent-1: var(--blue-1); /* links and other accent text */
      --accent-2: var(--blue-2); /* small accent elements */
      --accent-3: var(--blue-3); /* accent buttons */
      --accent-4: var(--blue-4); /* accent buttons when hovered */
      --accent-5: var(--blue-5); /* accent buttons when clicked */
      --accent-new: var(--accent-2);
      --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent);
      --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent);
      --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent);
      --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent);

      /* status indicator colors */
      --online: ${green};
      --dnd: ${red};
      --idle: ${yellow};
      --streaming: ${magenta};
      --offline: ${base04};

      /* border colors */
      --border-light: var(--hover); /* light border color */
      --border: var(--active); /* normal border color */
      --button-border: ${base03}; /* neutral border color of buttons */

      /* base colors */
      --red-1: ${red};
      --red-2: var(--red-1);
      --red-3: var(--red-1);
      --red-4: var(--red-1);
      --red-5: var(--red-1);

      --green-1: ${green};
      --green-2: var(--green-1);
      --green-3: var(--green-1);
      --green-4: var(--green-1);
      --green-5: var(--green-1);

      --blue-1: ${blue};
      --blue-2: var(--blue-1);
      --blue-3: var(--blue-1);
      --blue-4: var(--blue-1);
      --blue-5: var(--blue-1);

      --yellow-1: ${yellow};
      --yellow-2: var(--yellow-1);
      --yellow-3: var(--yellow-1);
      --yellow-4: var(--yellow-1);
      --yellow-5: var(--yellow-1);

      --purple-1: ${magenta};
      --purple-2: var(--purple-1);
      --purple-3: var(--purple-1);
      --purple-4: var(--purple-1);
      --purple-5: var(--purple-1);
  }
''
