require 'excon'
require 'simple_oauth'
require 'json'
require 'date'
require_relative 'http'

def timeline(options)
  username = options.first
  response = get("statuses/user_timeline", { :screen_name => username })
  response.map do |tweet|
    "@#{tweet["user"]["screen_name"]} - #{tweet["text"]}"
  end
end


def user_info(options)
  username = options.first
  response = get("users/show", { :screen_name => username })
  pertinent_data = {
    "Name" => response["name"],
    "Description" => response["description"],
    "Twitter Handle" => response["screen_name"],
    "Location" => response["location"],
    "Member Since" => Date.parse(response["created_at"]).strftime("%b %e, %Y")
  }

  pertinent_data.each_pair.map do |k,v|
    "#{k}: #{v}"
  end
end

def user_location(user)
  user["location"] == "" ? "Unknown" : user["location"]
end

def user_name(user)
  "#{user["screen_name"]} (A.k.a #{user["name"]})"
end

def user_description(user)
  user["description"] != "" ? "\n#{user["description"]}\n" : ""
end

def present_short_user(user)
    ("-"*10) + "\n" +
    "#{user_name(user)} - #{user_location(user)}\n" +
    user_description(user)
end

def followers(options)
  username = options.first
  response = get("followers/list", { :screen_name => username })
  response["users"].map do |user|
    present_short_user(user)
  end
end

def following(options)
  username = options.first
  response = get("friends/list", { :screen_name => username })
  response["users"].map do |user|
    present_short_user(user)
  end
end

def update(options)
  tweet = options.join(" ")
  response = post("statuses/update", { :status => tweet })
  ["Successfully tweeted '#{tweet}'"]
end

def message(options)
  user = options.shift
  message = options.join(" ")
  response = post("direct_messages/new", { :screen_name => user, :text => message })
  ["Successfully messaged #{user}"]
end

def twitter_app(command, options)
  if command == "timeline"
    return timeline(options)
  elsif command == "user_info"
    return user_info(options)
  elsif command == "followers"
    return followers(options)
  elsif command == "following"
    return following(options)
  elsif command == "update"
    return update(options)
  elsif command == "message"
    return message(options)
  else
    return ["We couldn't execute #{command} #{options.join(" ")}"]
  end
end
