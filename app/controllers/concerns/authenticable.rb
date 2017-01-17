module Authenticable

  # Devise override methods
  def current_author
    @current_author ||= Author.find_by(auth_token: request.headers['Authorization'])
  end

end