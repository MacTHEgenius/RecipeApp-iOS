require 'spec_helper'

describe Step do
  let(:step) { FactoryGirl.build :step }
  subject { step }

  it { should respond_to(:count) }
  it { should respond_to(:description) }
  it { should respond_to(:recipe_id) }

  it { should validate_presence_of(:count) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:recipe_id) }

  it { should validate_numericality_of(:count).is_greater_than_or_equal_to(1) }

  it { should validate_length_of(:description).is_at_least(5) }

  it { should belong_to :recipe }
end
