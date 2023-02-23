class AddUserIdToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :people, :integer
  end
end
