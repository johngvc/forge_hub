class ProfilesController < ApplicationController

  def show
    @user = current_user
    authorize @user
    @participations = Participant.where(user_id: @user.id)
    @projects = @participations.map do |participation|
      participation.project_id
    end
  end
end
