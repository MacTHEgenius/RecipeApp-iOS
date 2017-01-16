Rails.application.routes.draw do

  # API definition
  namespace :api, defaults: { format: :json }, contraints: { subdomain: 'api' }, path: '/' do

  end

end
