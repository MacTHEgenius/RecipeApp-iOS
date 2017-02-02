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

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        author = FactoryGirl.create :author
        @recipe_attributes = FactoryGirl.attributes_for :recipe
        api_authorization_header author.auth_token
        post :create, { author_id: author.id, recipe: @recipe_attributes }
      end

      it "renders the json representation fo the recipe record just created" do
        recipe_response = JSON.parse(response.body, symbolize_names: true)
        expect(recipe_response[:name]).to eql @recipe_attributes[:name]

        it { should respond_with 201 }
      end

      context "when is not created" do
        before(:each) do
          author = FactoryGirl.create :author
          @invalid_recipe_attributes = { name: "A recipe", cooking_duration: "a", baking_duration: "b" }
          api_authorization_header author.auth_token
          post :create, { author_id: author.id, recipe: @invalid_recipe_attributes }
        end

        it "renders an errors json" do
          recipe_response = JSON.parse(response.body, symbolize_names: true)
          expect(recipe_response).to have_key(:errors)
        end

        it "renders the json errors on why the author could not be created" do
          recipe_response = JSON.parse(response.body, symbolize_names: true)
          expect(recipe_response[:errors][:cooking_duration]).to include "is not a number"
          expect(recipe_response[:errors][:baking_duration]).to include "is not a number"
        end

        it { should respond_with 422 }
      end
    end
  end

end
