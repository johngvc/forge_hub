class ParticipantsController < ApplicationController
  before_action :find_project_id, only: %i[index new create]

  def index
    @participants = Participant.where(project_id: @project.id)
  end

  def new
    @participants = Participant.new
  end

  def create
    current_participant = Participant.where(project_id: @project[:id], user_id: current_user.id)
    @participant = Participant.new(participants_params, participant_id: current_participant[:id])
    if @participant.save
      redirect_to project_path(@participant.project), notice: "#{@participant.user.name} is now a project participant"
    else
      render :new
    end
  end

  private

  def find_project_id
    @project = Project.find(params[:project_id])
  end

  def participants_params
    params.require(:participants).permit(:project_id, :is_founder, :invited_at, :accepted_at, :clearence_level)
  end


  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "participant_id"
    t.boolean "is_founder", default: false
    t.datetime "invited_at"
    t.datetime "accepted_at"
    t.index ["participant_id"], name: "index_participants_on_participant_id"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"




end
