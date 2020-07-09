class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.jsonb :query

      t.timestamps
    end
  end
end
