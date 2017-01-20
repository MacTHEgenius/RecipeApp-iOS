require 'spec_helper'

describe Recipe do
  let(:recipe) { FactoryGirl.build :recipe }
  subject { recipe }

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

  it { should have_many :steps }
  it { should have_many :ingredients }
  it { should belong_to :author }

  describe "#steps association" do
    before do
      @recipe = FactoryGirl.build(:recipe)
      @recipe.save
      3.times { FactoryGirl.create :step, recipe: @recipe }
    end

    it "destroys the assocoated steps on self destruct" do
      steps = @recipe.steps
      @recipe.destroy
      steps.each { |step| expect(Step.find(step)).to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "#ingredients association" do
    before do
      @recipe = FactoryGirl.build(:recipe)
      @recipe.save
      3.times { FactoryGirl.create :ingredient, recipe: @recipe }
    end

    it "destroys the associated steps on self destruct" do
      ingredients = @recipe.ingredients
      @recipe.destroy
      ingredients.each { |ingredient| expect(Step.find(ingredient)).to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
