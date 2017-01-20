require 'spec_helper'

describe Api::V1::RecipesController do

  describe "GET #show" do
    before(:each) do
      @recipe = FactoryGirl.create :recipe
      get :show, id: @recipe.id
    end

    it "returns the infos about a recipe on a hash" do
      recipe_response = JSON.parse(response.body, symbolize_names: true)
      expect(recipe_response[:name]).to eql @recipe.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :recipe }
      get :index
    end

    it "returns 4 records from database" do
      recipes_response = JSON.parse(response.body, symbolize_names: true)
      expect(recipes_response[:recipes]).to have(4).items
    end

    it { should respond_with 200 }
  end

end
