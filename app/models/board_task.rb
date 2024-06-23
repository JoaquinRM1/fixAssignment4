class BoardTask < ApplicationRecord
  belongs_to :board
  belongs_to :task
end
