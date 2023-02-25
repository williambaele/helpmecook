class RenameColumnRate < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :rate, :rating
  end
end
