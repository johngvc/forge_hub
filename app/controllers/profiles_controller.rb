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
    message_counter(@messages_received_sorted)
  end

  def index_messages
    @messages_received = ChatMessage.where(user_receiver_id: current_user.id)
    @messages_sent = ChatMessage.where(user_sender_id: current_user.id)
    messages_received_sort = @messages_received.sort_by &:sent_at
    messages_sent_sort = @messages_sent.sort_by &:sent_at
    @messages_received_sorted = messages_received_sort.reverse
    @messages_sent_sorted = messages_sent_sort.reverse
  end

  def message_counter(messages_received_sorted)
    @new_message_count = 0
    messages_received_sorted.each do |message|
      if message.sent_at.after? current_user.last_sign_in_at
        @new_message_count += 1
        message.is_new_message = true
        message.save
      else
        message.is_new_message = false
        message.save
      end
    end
    unless @new_message_count.zero?
      @new_message_alert = true
    else
      @new_message_alert = false
    end
  end
end
