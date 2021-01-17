class RenameCommentColumnToUsers < ActiveRecord::Migration[6.0]

  def change
    rename_column :users, :comment, :profile
  end

end
