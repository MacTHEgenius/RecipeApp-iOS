class Api::V1::RecipesController < ApplicationController

  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  # GET (all)

  def index
    respond_with Recipe.all
  end

  # GET (by id)

  def show
    respond_with Recipe.find(params[:id])
  end

  # POST

  def create
    recipe = current_author.recipes.build()
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :cooking_duration, :baking_duration)
    end

end
