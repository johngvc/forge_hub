class ProfilesController < ApplicationController
  # before_action :set_adoption_requests, only: %i[show]

  def show
    @user = current_user
    authorize @user
    
    omniauth = request.env["omniauth.auth"]
    first_name = omniauth[:info][:first_name]
    last_name = omniauth[:info][:last_name]
    # summary = omniauth[:extra][:raw_info][:summary]
    # headline = omniauth[:extra][:raw_info][:headline]
    image = omniauth[:info][:image]
    email = omniauth[:info][:email]
    # profile_url = omniauth[:info][:urls][:public_profile]
    @participations = Participant.where(user_id: @user.id)
    @projects = @participations.map do |participation|
      participation.project_id
    end
  end
end
