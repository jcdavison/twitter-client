def request(method, path, params)
  header = SimpleOAuth::Header.new(method,
                                   "https://api.twitter.com/1.1/#{path}.json",
                                   params,
                                   { :consumer_key => CONSUMER_KEY,
                                     :consumer_secret => CONSUMER_SECRET,
                                     :token => ACCESS_TOKEN,
                                     :token_secret => ACCESS_TOKEN_SECRET })

  response = Excon.send(method, "https://api.twitter.com/1.1/#{path}.json", {
    :query => params,
    :headers => { "Authorization" => header.to_s }
  })

  parsed_response = JSON.parse(response.body)
  if parsed_response["errors"]
    errors = parsed_response["errors"].map do |error|
      "  * #{error["message"]}"
    end.join("\n")
    raise "\nRequest for #{path} with params #{params} failed for the following reasons:\n #{errors}"
  end

  parsed_response
end

def post(path, params)
  request(:post, path, params)
end

def get(path, params)
  request(:get, path, params)
end
