module Authenticable

  # Devise override methods

  def current_author
    @current_author ||= Author.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless current_author.present?
  end

end