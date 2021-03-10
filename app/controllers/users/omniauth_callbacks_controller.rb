class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def auth
    omniauth = request.env['omniauth.auth']
  end

  def linkedin
    user = User.where(uid: auth.uid).first_or_create! do |user|
      user.uid = auth.uid
      user.provider = "linkedin"
      user.first_name = auth.info['first_name']
      user.last_name = auth.info['last_name']
      user.name = "#{auth.info['first_name']} #{auth.info['last_name']}"
      user.email = auth.info['email']
      user.picture_url = auth.info['picture_url']
      user.password = Devise.friendly_token.first(8)
      user.current_sign_in_at = DateTime.now
    end

    sign_in_and_redirect user, notice:"You are logged in with LinkedIn!"
  end
end
