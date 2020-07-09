require 'rails_helper'

RSpec.describe "Api::V1::Cards", type: :request do
  describe 'index' do
    it 'returns a list of cards with no params' do
      VCR.use_cassette('/requests/index_no_params') do
        get api_v1_cards_path

        result = JSON.parse(response.body).symbolize_keys

        expect(response).to have_http_status(:success)
      end
    end

    it 'returns a list of cards with filtered by name' do

    end

    it 'returns a list of cards filtered by color' do

    end

    it 'returns a list of cards filtered by color and sorted by name' do

    end

    context 'errors' do
      it 'returns valid JSON when passed invalid parameters' do

      end
    end
  end
end
