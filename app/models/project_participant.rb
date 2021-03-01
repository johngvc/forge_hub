class ProjectParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :project_participant
  belongs_to :project
end
