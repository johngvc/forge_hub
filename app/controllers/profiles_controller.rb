class ProfilesController < ApplicationController
  # before_action :set_adoption_requests, only: %i[show]

  def show
    @user = current_user

    @participations = Participant.where(user_id: @user.id)
    @projects = @participations.map do |participation|
      participation.project_id
    end
  end

end
