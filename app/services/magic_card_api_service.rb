# Service object to consume Magic The Gathering API
class MagicCardApiService
  class InvalidParametersError < StandardError # defined here for sake of time
    def message
      'Invalid parameters entered. Allowed parameters can be found in
       the README at https://github.com/MikelSage/magic-card-api'
    end
  end

  def initialize(search_params)
    @conn = Faraday.new('https://api.magicthegathering.io/v1/') do |c|
      c.use Faraday::Response::RaiseError
    end

    @query = search_params

    raise InvalidParametersError unless all_parameters_valid?

    @search = Search.find_or_create_by(query: @query) #convert to method to create search and check for cache
  end

  def self.find_cards(search_params)
    new(search_params).find_cards
     # add checking for cached response here
  end

  def find_cards
    response = @conn.get('cards', @query)
    results = JSON.parse(response.body, symbolize_names: true)[:cards]
    # cache results
  end

  private

    def all_parameters_valid?
      allowed_params = %w[name colors mana_cost cmc power toughness orderBy page pageSize]
      # extremely contrived way to raise error, couldn't think of another way in time constraints
      @query.to_unsafe_hash.except('action', 'controller').all? do |param_name, _param_value|
        allowed_params.include?(param_name)
      end
    end
end
