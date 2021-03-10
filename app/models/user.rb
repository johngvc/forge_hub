class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[linkedin]
  has_many :projects, through: :participants, dependent: :delete_all
  has_many :messages, through: :chat_threads, dependent: :delete_all
  has_many :chat_threads, dependent: :delete_all
  has_one_attached :photo

  validates :email, presence: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 25 }

end

