class Api::V1::CardsController < ApplicationController
  rescue_from MagicCardApiService::InvalidParametersError do |e|
    render json: {
      errors: [
        detail: e.message
      ]
    }, status: 400
  end

  def index
    cards = Card.find_by_query(params)
    render json: CardSerializer.new(cards, is_collection: true)
  end
end
