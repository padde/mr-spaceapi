class Door
  DEFAULT_STATUS = {
    'address' => 'Marienstr. 18, 99423 Weimar, Germany, Earth, Milky Way',
    'api' => '0.12',
    'contact' => {
      'email' => 'mr@m18.uni-weimar.de',
      'irc' => 'irc://freenode/maschinenraum',
      'ml' => 'feint@lists.subsignal.org',
      'phone' => '+493643583031',
      'twitter' => '@maschinenrauM18'
    },
    'feeds' => [
      {
        'name' => 'blog',
        'type' => 'application/rss+xml',
        'url' => 'http://blog.maschinenraum.tk/feed/rss2/'
      },
      {
        'name' => 'facebook',
        'type' => 'application/rss+xml',
        'url' => 'https://www.facebook.com/feeds/page.php?id=273838003013&format=rss20'
      },
      {
        'name' => 'github',
        'type' => 'application/rss+xml',
        'url' => 'https://github.com/maschinenraum.atom'
      }
    ],
    'icon' => {
      'closed' => 'http://fakeimg.pl/100x100/ff0000/444/?text=CLOSED&font=bebas',
      'open' => 'http://fakeimg.pl/100x100/00ff00/444/?text=OPEN&font=bebas'
    },
    # 'lastchange' => 123,
    # 'generated_at' => 123,
    'lat' => 50.9749425174,
    'logo' => 'http://fakeimg.pl/500x200/000000/00aa00/?text=maschinenraum&font=bebas',
    'lon' => 11.3295217752,
    # 'open' => false,
    # 'status' => 'Door is closed!',
    'space' => 'Maschinenraum',
    'tagline' => 'we can haz raum',
    'url' => 'http://maschinenraum.tk'
  }

  attr_accessor :status

  def initialize
    @latest_tweet = Twitter.user_timeline('mr_door_status', count: 1).first
    @status = DEFAULT_STATUS
    update_status
  end

  def update_status
    @status['lastchange']   = status_lastchange
    @status['generated_at'] = status_generated_at
    @status['open']         = status_open
    @status['status']       = status_status
    @status = Hash[@status.sort_by(&:first)]
  end

  def is_open?
    @latest_tweet.text.include? 'OFFEN'
  end

  private

  def status_lastchange
    @latest_tweet.created_at.to_i
  end

  def status_generated_at
    Time.now.to_i
  end

  def status_open
    is_open?
  end

  def status_status
    is_open? ? 'Door is open!' : 'Door is closed!'
  end
end
