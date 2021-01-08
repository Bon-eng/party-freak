class CreateParties < ActiveRecord::Migration[6.0]
  def change
    create_table :parties do |t|

      t.string  :name,          null: false
      t.text    :introduction,  null: false
      t.integer :season_id,     null: false
      t.integer :country_id,    null: false
      t.integer :genre_id,      null: false
      t.text    :picture

      t.timestamps

    end
  end
end
