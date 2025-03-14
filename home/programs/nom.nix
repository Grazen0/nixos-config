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

      subreddits = [
        "unixporn"
        "nixos"
        "neovim"
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
      ];

      extraFeeds = [
        {
          url = "https://isaacfreund.com/blog/feed.xml";
          name = "Isaac Freund";
        }
        "asdf"
      ];
    in
      (map mkRedditFeed subreddits) ++ (map mkYtFeed ytChannels) ++ extraFeeds;

    extraConfig = {
      showread = true;
      theme = let
        colors = config.theme.colors.hexWithHashtag;
      in {
        titleColor = colors.blue;
        selectedItemColor = colors.yellow;
        filterColor = colors.red;
      };
    };
  };
}
