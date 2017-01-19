require 'spec_helper'

describe Ingredient do
  let(:ingredient) { FactoryGirl.build :ingredient }
  subject { ingredient }

  it { should respond_to(:name) }
  it { should respond_to(:quantity) }
  it { should respond_to(:recipe_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:recipe_id) }

  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0.0) }

  it { should validate_length_of(:name).is_at_least(3) }
  it { should validate_length_of(:name).is_at_most(100) }
end
