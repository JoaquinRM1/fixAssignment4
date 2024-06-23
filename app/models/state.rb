class State < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  validates :state_name, presence: true
  validates :board_id, presence: true
end
