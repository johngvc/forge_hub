class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth
    request.env['omniauth.auth']
  end
  def linkedin
    p auth
    redirect_to root_path, notice:"You are logged in with LinkedIn!"
  end
end