class AddDataToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :content, :text
    add_column :comments, :rate, :integer
    add_reference :comments, :user, foreign_key: true
  end
end
