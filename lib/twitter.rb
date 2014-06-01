require 'excon'
require 'simple_oauth'
require 'json'

def timeline(options)
  username = options.first
  header = SimpleOAuth::Header.new(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json", { :screen_name => "zspencer" }, { :consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET })

  response = Excon.get('https://api.twitter.com/1.1/statuses/user_timeline.json', {
    :query => { :screen_name => "zspencer" },
    :headers => { "Authorization" => header.to_s }
  })

  JSON.parse(response.body).map do |tweet|
    "@#{tweet["user"]["screen_name"]} - #{tweet["text"]}"
  end
end


def twitter_app(command, options)
  if command == "timeline"
    return timeline(options)
  end
end
