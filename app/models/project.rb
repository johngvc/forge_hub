class Project < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :participants, dependent: :delete_all
  has_many :join_requests, dependent: :delete_all
  has_many :project_tags, dependent: :delete_all
  has_many :tags, through: :project_tags
  has_many :chat_messages
  has_one_attached :photo
  has_rich_text :content

  validates :name, presence: true, length: { maximum: 22 }
  validates :description, presence: true, length: { maximum: 135 }
  validates :status_project, inclusion: { in: ['idea', 'design', 'pre-production', 'development', 'growth'],
                                          message: "%{value} is not a valid project status" }

  pg_search_scope :global_search,
                  associated_against: {
                    tags: %i[name]
                  },
                  using: {
                    tsearch: { prefix: true, any_word: true }
                  }
end
