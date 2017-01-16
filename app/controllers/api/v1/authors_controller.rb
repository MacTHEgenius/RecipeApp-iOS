class Api::V1::AuthorsController < ApplicationController

  respond_to :json

  # GET

  def show
    respond_with Author.find(params[:id])
  end

end
