class Api::V1::SessionsController < ApplicationController

  # POST

  def create
    author_password = params[:session][:password]
    author_email = params[:session][:email]
    author = author_email.present? && Author.find_by(email: author_email)

    if author.valid_password? author_password
      sign_in author, store: false
      author.generate_authentication_token!
      author.save
      render json: author, status: 200, location: [:api, author]
    else
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  end

  # DELETE

  def destroy

  end

end
