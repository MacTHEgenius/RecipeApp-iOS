class Recipe < ActiveRecord::Base

  validates :name, :author_id, presence: true
  validates :cooking_duration, :baking_duration, numericality: { greater_than_or_equal_to: 0 }, presence: true

  has_many :steps, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  belongs_to :author

end