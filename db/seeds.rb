# Crear usuarios
#

# db/seeds.rb

# Clear existing records to avoid duplication
Task.destroy_all
State.destroy_all
BoardTask.destroy_all
BoardEditor.destroy_all
Board.destroy_all
User.destroy_all

# Create users
users = []
3.times do |i|
  users << User.create!(
    username: "user#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password",
    account_type: 1
  )
end

# Create boards and associate with users
boards = []
3.times do |i|
  board = Board.create!(
    board_name: "Board #{i + 1}",
    user: users.sample # Assuming board has a creator who is a user
  )
  boards << board

  # Associate board editors
  2.times do
    BoardEditor.create!(
      board: board,
      user: users.sample
    )
  end

  # Create states for each board
  state_names = ["To Do", "In Progress", "Done"]
  states = state_names.map { |name| board.states.create!(state_name: name) }

  # Create tasks for each board
  5.times do |k|
    task = Task.create!(
      board: board,
      state: states.sample,
      title: "Task #{k + 1} for #{board.board_name}",
      description: "Description for Task #{k + 1}",
      informer: users.sample,
      assignee: users.sample,
      user: users.sample, # This user is necessary because of the belongs_to association in Task
      status: state_names.sample,
      priority: rand(1..5)
    )

    # Associate task with the board through BoardTask
    BoardTask.create!(
      board: board,
      task: task
    )
  end
end

ENV.delete('SEEDING')

puts "Seeding completed successfully!"
