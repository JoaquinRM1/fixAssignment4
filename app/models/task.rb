class Task < ApplicationRecord
  belongs_to :board
  belongs_to :state
  belongs_to :user # This association should exist if you want to assign a user to a task
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :informer, class_name: 'User', optional: true

  has_many :board_tasks
  has_many :boards, through: :board_tasks

  validates :title, presence: true
  validates :board_id, presence: true
  validates :user_id, presence: true # Ensure user_id is present to assign a user to a task
end
