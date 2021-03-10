class ProfilesController < ApplicationController
# require 'chat_messages_controller'
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
    index_messages
  end

  def index_messages
    @messages = ChatMessage.where(user_receiver_id: current_user.id) + ChatMessage.where(user_sender_id: current_user.id)
    messages_2 = @messages.sort_by &:sent_at
    @messages_sorted = messages_2.reverse
    @new_messsage_counter = 0
  end
end
