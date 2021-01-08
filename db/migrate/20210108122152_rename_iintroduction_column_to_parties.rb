class RenameIintroductionColumnToParties < ActiveRecord::Migration[6.0]
  
  #カラム名間違えてしまった為、rename
  def change
    rename_column :parties, :iintroduction, :introduction
  end
end
