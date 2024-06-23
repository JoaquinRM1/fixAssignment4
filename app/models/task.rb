class Task < ApplicationRecord
  belongs_to :board
  belongs_to :state
  belongs_to :informer, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :title, presence: true
  validates :board_id, presence: true
  validates :state_id, presence: true
end
