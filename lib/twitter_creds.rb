# unless ENV.keys.include?("API_KEY") && ENV.keys.include?("API_SECRET")
#   $stderr.puts """
#   Woops! It looks like you haven't placed your twitter credentials in `.env`

#   Make sure you followed all the steps for registering your application:
#   https://github.com/codeunion/twitter-client/blob/master/docs/twitter.md#registering-your-application"""
# end

# Get these from https://apps.twitter.com/ in your applications API Keys tab.
API_KEY=ENV['STARTUPLANDIA_API_KEY']
API_SECRET=ENV['STARTUPLANDIA_API_SECRET']
ACCESS_TOKEN=ENV['STARTUPLANDIA_ACCESS_TOKEN']
ACCESS_TOKEN_SECRET=ENV['STARTUPLANDIA_ACCESS_TOKEN_SECRET']
