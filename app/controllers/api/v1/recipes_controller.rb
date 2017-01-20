class Api::V1::RecipesController < ApplicationController

  respond_to :json

  # GET (all)

  def index
    respond_with Recipe.all
  end

  # GET (by id)

  def show
    respond_with Recipe.find(params[:id])
  end

end
