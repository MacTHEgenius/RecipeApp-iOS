class Recipe < ActiveRecord::Base

  validates :name, :author_id, presence: true
  validates :cooking_duration, :baking_duration, numericality: { greater_than_or_equal_to: 0 }, presence: true

end