class RenameDateIdColumnToParties < ActiveRecord::Migration[6.0]

    #カラム名間違えてしまった為、rename
  def change
    rename_column :parties, :date_id, :season_id
  end
end
