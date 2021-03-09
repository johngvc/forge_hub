class ProfilesController < ApplicationController
require 'chat_messages_controller'
  # before_action :set_adoption_requests, only: %i[show]

  def show
    @user = User.find(params[:id])
    authorize @user

    @participations = Participant.where(user_id: @user.id)
    @projects = @participations.map do |participation|
      participation.project_id
    end

    @projects = Project.all
    @projects = policy_scope(Project)
    @participating_projects = []
    @available_projects = []
    @suspended_projects_participating = []
    @ongoing_projects_participating = []

    @projects.each do |project|
      is_part_of_project = !Participant.where(project_id: project, user_id: @user.id).first.nil?

      if is_part_of_project
        @participating_projects << project
        if !project.is_suspended?
          @ongoing_projects_participating << project
        elsif project.is_suspended?
          @suspended_projects_participating << project
        end
      elsif !is_part_of_project
        @available_projects << project
      end
    end
  end

  def create_message
    @user_sender = current_user
    @user_receiver = User.find(email: params[:user_receiver])
    @message = Message.new(message_params)
    @message.user_sender = @user_sender.id
    @message.sent_at = DateTime.now
    if @message.save
      redirect_to profile_path(id: current_user.id), notice: "Your message was sent."
    else
      render :new, notice: "Something went wrong. Your message could not be sent."
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:user_receiver, :content, :previous_message_id)
  end

end
