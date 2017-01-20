class Step < ActiveRecord::Base

  validates :count, numericality: { greater_than_or_equal_to: 1}, presence: true
  validates :description, length: { minimum: 5 }, presence: true
  validates :recipe_id, presence: true

  belongs_to :recipe

end
