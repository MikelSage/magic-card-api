# Service object to consume Magic The Gathering API
class MagicCardApiService
  def initialize(search_params)
    @conn = Faraday.new(url: 'https://api.magicthegathering.io/v1/')
    @params = search_params
    @search = Search.find_or_create_by(@params) #convert to method to create search and check for cache
  end

  def self.find_cards(search_params)
    new(search_params).find_cards
     # add checking for cached response here
  end

  def find_cards
    response = @conn.get('cards', @search_params)
    results = JSON.parse(response.body, symbolize_names: true)[:cards]
    # cache results
  end
end
