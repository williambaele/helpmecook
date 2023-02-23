class Recipe < ApplicationRecord
  validates :title, :description, presence: true
end
