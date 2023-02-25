class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :content, :rating, presence: true
  validates :content, length: { minimum: 10, maximum: 1000 }
end
