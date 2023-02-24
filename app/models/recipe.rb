class Recipe < ApplicationRecord
  validates :title, :description, :people, presence: true
  belongs_to :user
  include PgSearch::Model
  pg_search_scope :search_by_title_description,
  against: [ :title, :description ],
  using: {
    tsearch: { prefix: true }
  }
end
