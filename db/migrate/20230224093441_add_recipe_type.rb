class AddRecipeType < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :recipe_type, :string
  end
end
