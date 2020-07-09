# PORO for dealing with Cards from MTG API
class Card
  attr_reader :id,
              :name,
              :mana_cost,
              :converted_mana_cost,
              :power,
              :toughness,
              :types,
              :rarity,
              :colors

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @mana_cost = attrs[:manaCost]
    @converted_mana_cost = attrs[:cmc]
    @power = attrs[:power]
    @toughness = attrs[:toughness]
    @types = attrs[:types]
    @rarity = attrs[:rarity]
    @colors = attrs[:colors]
  end

  def self.find_by_query(query)
    raw_data = MagicCardApiService.find_cards(query)
    raw_data.map do |raw_card|
      new(raw_card)
    end
  end
end
