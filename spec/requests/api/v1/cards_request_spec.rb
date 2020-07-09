require 'rails_helper'

RSpec.describe "Api::V1::Cards", type: :request do
  describe 'index' do
    it 'returns a list of cards with no params' do
      VCR.use_cassette('/requests/index_no_params') do
        get api_v1_cards_path

        result = JSON.parse(response.body).deep_symbolize_keys
        example_card = result[:data].first

        expect(response).to have_http_status(:success)
        expect(result[:data].count).to eq 100 # max number of cards returned by MTG API
        expect(example_card).to have_key :id
        expect(example_card[:id]).to be_a String
        expect(example_card[:attributes]).to have_key :convertedManaCost
        expect(example_card[:attributes][:convertedManaCost]).to be_a Integer
      end
    end

    it 'returns a list of cards with filtered by name' do
      VCR.use_cassette('/requests/index_filter_by_name') do
        get '/api/v1/cards?name=jace'

        result = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(:success)
        expect(result[:data].count).not_to eq 0
        expect(result[:data]).to all(include(
          attributes: a_hash_including(
            :name => a_string_matching(/jace/i)
          )
        ))
      end
    end

    it 'returns a list of cards filtered by color' do
      VCR.use_cassette('/requests/index_filter_by_color') do
        get '/api/v1/cards?colors=white,blue'

        result = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(:success)
        expect(result[:data].count).not_to eq 0
        expect(result[:data]).to all(include(
          attributes: a_hash_including(
            :colors => a_collection_including("White", "Blue")
          )
        ))
      end
    end

    it 'returns a list of cards filtered by color and sorted by name' do
      VCR.use_cassette('/requests/index_filter_by_color_and_sort_by_name') do
        get '/api/v1/cards?colors=white,blue&orderBy=name'

        result = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(:success)
        expect(result[:data].count).not_to eq 0
        expect(result[:data]).to all(include(
          attributes: a_hash_including(
            :colors => a_collection_including("White", "Blue")
          )
        ))

        first_card = result[:data].shift
        first_card_name = first_card.dig(:attributes, :name)

        expect(result[:data]).to all(include(
          attributes: a_hash_including(
            :name => an_object_satisfying {|name| name > first_card_name}
          )
        ))
      end
    end

    context 'errors' do
      it 'returns valid JSON when passed invalid parameters' do
        get '/api/v1/cards?sname=jace' # misspelled name parameter

        result = JSON.parse(response.body).deep_symbolize_keys
        expect(response).to have_http_status(400)
        expect(result).to have_key :errors
        expect(result[:errors].first[:detail]).to be_a String
      end
    end
  end
end
