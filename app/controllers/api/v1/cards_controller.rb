class Api::V1::CardsController < ApplicationController
  def index
    render json: Card.find_by_query(params)
  end
end
