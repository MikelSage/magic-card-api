require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it 'does not allow non-unique queries to be saved' do
      query = { colors: '["green", "blue"]', types: 'creature' }
      query_with_different_order = { types: 'creature', colors: '["green", "blue"]'}

      valid_search = Search.create(query: query)
      invalid_search = Search.create(query: query_with_different_order)

      expect(valid_search.valid?).to be true
      expect(invalid_search.valid?).to be false
      expect(invalid_search.errors.messages[:query]).to include('has already been taken')
    end
  end
end
