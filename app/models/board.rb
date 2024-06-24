class Board < ApplicationRecord
  belongs_to :user

  has_many :user_boards
  has_many :users, through: :user_boards
  has_many :states, dependent: :destroy
  has_many :tasks, dependent: :destroy

  after_create :create_default_states, unless: -> { ENV['SEEDING'] }

  private

  def create_default_states
    states.create(state_name: 'To Do')
    states.create(state_name: 'In Progress')
    states.create(state_name: 'Done')
  end
end
