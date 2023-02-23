class AddDataToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :title, :string
    add_column :recipes, :description, :string
  end
end
