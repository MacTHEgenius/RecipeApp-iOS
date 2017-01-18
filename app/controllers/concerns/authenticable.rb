module Authenticable

  # Devise override methods

  def current_author
    @current_author ||= Author.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless author_signed_in?
  end

  def author_signed_in?
    current_author.present?
  end

end