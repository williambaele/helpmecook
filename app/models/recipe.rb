class Recipe < ApplicationRecord
  validates :title, :description, :people, :time, :budget, :recipe_type, presence: true
  validates :description, length: { minimum: 50, maximum: 500 }
  validates :title, length: { minimum: 10, maximum: 100 }

  belongs_to :user
  include PgSearch::Model
  pg_search_scope :search_by_title_description,
  against: [ :title, :description ],
  using: {
    tsearch: { prefix: true }
  }
end
