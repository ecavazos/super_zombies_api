require 'rest-client'
require 'yajl'

module SuperZombiesApi
  class Client

    def initialize
      # This is hard-coded to be localhost (for now).
      # Deal with it! http://pichars.org/store/4110_original_dealwithitneti.gif
      @host = 'http://localhost:3000'
    end

    def zombies
      response = RestClient.get "#{ @host }/api/v1/zombies.json"
      Yajl.load response.body
    end

    def reanimate post_data
      response = RestClient.post "#{ @host }/api/v1/zombies.json", post_data
      Yajl.load response.body
    end

    def horde post_data
      post_data['zombies[]'] = post_data.delete(:zombies)
      response = RestClient.post "#{ @host }/api/v1/horde.json", post_data
      Yajl.load response.body
    end
  end
end
