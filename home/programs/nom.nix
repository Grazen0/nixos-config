{config, ...}: {
  programs.nom = {
    enable = true;

    feeds = let
      mkRedditFeed = subreddit: {
        url = "https://www.reddit.com/r/${subreddit}/.rss";
        name = "r/${subreddit}";
      };

      mkYtFeed = {
        id,
        name,
      }: {
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=${id}";
        inherit name;
      };

      mkBlueSkyFeed = {
        did,
        name,
      }: {
        url = "https://bsky.app/profile/${did}/rss";
        inherit name;
      };

      subreddits = [
        "unixporn"
        "NixOS"
        "neovim"
        "rust"
        "math"
      ];

      ytChannels = [
        {
          id = "UCZaFfDBBCqmYdfp6DJl0cRw";
          name = "Akatsuki Records";
        }
        {
          id = "UCOxvBvlRGKjf0ZWfVEdneKA";
          name = "Shinra-Bansho";
        }
        {
          id = "UCYO_jab_esuFRV4b17AJtAw";
          name = "3Blue1Brown";
        }
        {
          id = "UCm8EsftbfNzSiRHzc7I59KQ";
          name = "Kevin Fang";
        }
      ];

      blueSkyAccounts = [
        {
          did = "did:plc:ewvi7nxzyoun6zhxrhs64oiz";
          name = "tobyfox";
        }
      ];

      extraFeeds = [
        {
          url = "https://isaacfreund.com/blog/feed.xml";
          name = "Isaac Freund";
        }
      ];
    in
      (map mkRedditFeed subreddits)
      ++ (map mkYtFeed ytChannels)
      ++ (map mkBlueSkyFeed blueSkyAccounts)
      ++ extraFeeds;

    extraConfig = {
      showread = true;
      theme = let
        colors = config.theme.colors.hexWithHashtag;
      in {
        titleColor = colors.blue;
        selectedItemColor = colors.magenta;
        filterColor = colors.yellow;
      };
    };
  };
}
