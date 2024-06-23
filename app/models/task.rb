class Task < ApplicationRecord
  belongs_to :board
  belongs_to :state
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :informer, class_name: 'User', optional: true

  has_many :board_tasks
  has_many :boards, through: :board_tasks

  validates :title, presence: true
  validates :board_id, presence: true
  validates :user_id, presence: true
end
