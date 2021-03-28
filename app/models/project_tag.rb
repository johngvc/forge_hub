class ProjectTag < ApplicationRecord
  belongs_to :project
  belongs_to :tag
  validates :project, uniqueness: { scope: :tag,
                                  message: "You can't add several times same tag" }
end
