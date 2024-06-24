class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :boards
  has_many :tasks
  has_many :board_editors, dependent: :destroy
  has_many :editable_boards, through: :board_editors, source: :board

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
