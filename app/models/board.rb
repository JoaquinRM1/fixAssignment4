class Board < ApplicationRecord
  belongs_to :user
  has_many :board_tasks
  has_many :states
  has_many :tasks
  has_many :states, dependent: :destroy

  after_create :create_default_states, unless: -> { ENV['SEEDING'] }

  private

  def create_default_states
    State.create(state_name: 'To Do', board_id: self.id)
    State.create(state_name: 'In Progress', board_id: self.id)
    State.create(state_name: 'Done', board_id: self.id)
  end
end
