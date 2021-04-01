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
  validates :category, inclusion: { in: ['Arts', 'Comics & Illustration', 'Design & Tech', 'Film', 'Food & Craft', 'Games', 'Music', 'Publishing'],
                                    message: "%{value} is not a valid project status" }

  # Configuracao para o search utilizando a gema "pg_search"
  pg_search_scope :search_by_tag,
                  associated_against: {
                    tags: %i[name]
                  },
                  using: {
                    tsearch: { prefix: true, any_word: true }
                  }

  pg_search_scope :global_search_association, lambda { |associated_against_arr = [], associated_model, query|
    associated_against_arr.each do |element|
      raise ArgumentError unless %i[name].include?(element)
    end

    {
      associated_against: {
        associated_model.to_sym => associated_against_arr
      },
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }

  pg_search_scope :global_search, lambda { |against_arr = [], query|
    against_arr.each do |element|
      raise ArgumentError unless %i[name description status_project category].include?(element)
    end

    {
      against: against_arr,
      query: query,
      using: {
        tsearch: { prefix: true }
      }
    }
  }
end
