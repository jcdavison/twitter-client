##
# This method is the main entrance to our twitter application. It takes the
# command the user wants to execute and an array containing everything else that
# was passed in.
#
# It's up to you to decide what this function returns; But I'd recommend an
# array of strings to present to the user.
#
# Examples:
#   run_app("timeline", ["zspencer"])
#   run_app("post", ["Wow!", "@CodeUnionIO", "is", "the", "greatest!"])
#   run_app("message", ["jfarmer", "Huh", "the", "more", "you", "know..."])
#
require 'pry'
require 'simple_oauth'
require 'excon'
require 'json'

TWITTER_USER = "startuplandia"

def run_app(command, arguments)
  if command.match(/get_timeline/)
    get_timeline(arguments[0])
  end
end

def get_timeline(screen_name)
  authorization_header = SimpleOAuth::Header.new("get",
                                                      "https://api.twitter.com/1.1/statuses/user_timeline.json",
                                                      { :screen_name => screen_name },
                                                      { :consumer_key => ENV['STARTUPLANDIA_API_KEY'],
                                                        :consumer_secret => ENV['STARTUPLANDIA_API_SECRET']} )
  response = Excon.send("get", "https://api.twitter.com/1.1/statuses/user_timeline.json", {
    :query => { :screen_name => screen_name },
    :headers => { "Authorization" => authorization_header.to_s }
  })
  tweets = JSON.parse(response.body)
  puts tweets.map {|tweet| tweet["text"] + "\n--\n" }
end


def update_status(screen_name)
  authorization_header = SimpleOAuth::Header.new("post",
                                                      "https://api.twitter.com/1.1/statuses/update.json",
                                                      { :screen_name => screen_name },
                                                      { :consumer_key => ENV['STARTUPLANDIA_API_KEY'],
                                                        :consumer_secret => ENV['STARTUPLANDIA_API_SECRET']} )
  response = Excon.send("get", "https://api.twitter.com/1/statuses/update.json", {
    :query => { :screen_name => screen_name },
    :headers => { "Authorization" => authorization_header.to_s }
  })
  tweets = JSON.parse(response.body)
  puts tweets.map {|tweet| tweet["text"] + "\n--\n" }
end
