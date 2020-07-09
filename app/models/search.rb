class Search < ApplicationRecord
  validates :query, uniqueness: true, presence: true
end
