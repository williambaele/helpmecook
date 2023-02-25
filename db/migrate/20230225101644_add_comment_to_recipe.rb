class AddCommentToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :recipe, foreign_key: true
  end
end
