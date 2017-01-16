class Api::V1::AuthorsController < ApplicationController

  respond_to :json

  # GET

  def show
    respond_with Author.find(params[:id])
  end

  # POST

  def create
    author = Author.new(author_params)
    if author.save
      render json: author, status: 201, location: [:api, author]
    else
      render json: { errors: author.errors }, status: 422
    end
  end

  # PUT - PATCH

  def update
    author = Author.find(params[:id])
    if author.update(author_params)
      render json: author, status: 200, location: [:api, author]
    else
      render json: { errors: author.errors }, status: 422
    end
  end

  # DELETE

  def destroy
    author = Author.find(params[:id])
    author.destroy
    head 204
  end

  private
    def author_params
      params.require(:author).permit(:email, :password, :password_confirmation)
    end

end
