require 'spec_helper'

describe Recipe do
  before { @recipe = FactoryGirl.build(:recipe) }
  subject { @recipe }

  it { should respond_to(:name) }
  it { should respond_to(:cooking_duration) }
  it { should respond_to(:baking_duration) }
  it { should respond_to(:author_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cooking_duration) }
  it { should validate_presence_of(:baking_duration) }
  it { should validate_presence_of(:author_id) }

  it { should validate_numericality_of(:cooking_duration).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:baking_duration).is_greater_than_or_equal_to(0) }
end
