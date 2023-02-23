class AddSeveralDataToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :difficulty, :integer
    add_column :recipes, :type, :string
    add_column :recipes, :budget, :string
    add_column :recipes, :time, :integer
  end
end
