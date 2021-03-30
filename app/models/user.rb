class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  devise :omniauthable, omniauth_providers: %i[linkedin]
  has_many :projects, through: :participants, dependent: :delete_all
  has_many :user_specialties, dependent: :delete_all
  has_many :specialties, through: :user_specialties
  # has_many :chat_messages, foreign_key: :user_sender_id, dependent: :delete_all
  # has_many :chat_messages, foreign_key: :user_receiver_id
  has_one_attached :photo

  validates :email, presence: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 80 }

end

