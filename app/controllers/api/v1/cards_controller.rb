class Api::V1::CardsController < ApplicationController
  def index
    cards = Card.find_by_query(params)
    render json: CardSerializer.new(cards, is_collection: true)
  end
end
