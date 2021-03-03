class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :projects
end
