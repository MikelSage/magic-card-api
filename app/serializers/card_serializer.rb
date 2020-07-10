class CardSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :name,
             :mana_cost,
             :converted_mana_cost,
             :power,
             :toughness,
             :types,
             :rarity,
             :colors
end
