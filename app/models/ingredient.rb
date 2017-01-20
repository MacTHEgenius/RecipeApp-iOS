class Ingredient < ActiveRecord::Base

  validates :name, length: {minimum: 3, maximum: 100}, presence: true
  validates :quantity, numericality: {greater_than_or_equal_to: 0.0}, presence: true
  validates :recipe_id, presence: true

  belongs_to :recipe

end
