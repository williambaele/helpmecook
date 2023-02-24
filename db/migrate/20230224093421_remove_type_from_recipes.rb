class RemoveTypeFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :type, :string
  end
end
