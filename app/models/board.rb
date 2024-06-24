class Board < ApplicationRecord
  belongs_to :user
  has_many :board_editors, dependent: :destroy
  has_many :editors, through: :board_editors, source: :user
  has_many :states, dependent: :destroy
  has_many :tasks, dependent: :destroy

  after_create :create_default_states, :add_creator_as_editor

  private

  def create_default_states
    State.create(state_name: 'To Do', board_id: self.id)
    State.create(state_name: 'In Progress', board_id: self.id)
    State.create(state_name: 'Done', board_id: self.id)
  end

  def add_creator_as_editor
    self.editors << self.user
  end
end
