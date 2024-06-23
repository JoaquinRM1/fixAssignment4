# Crear usuarios
#

ENV['SEEDING'] = 'true'

User.create!(username: "user1", email: "user1@example.com", password: "password", account_type: 1)
User.create!(username: "user2", email: "user2@example.com", password: "password", account_type: 1)
User.create!(username: "user3", email: "user3@example.com", password: "password", account_type: 1)

# puts "User ids: #{User.pluck(:id)}"

# Crear tableros
boards = []
3.times do |i|
  board = Board.create!(board_name: "Board #{i + 1}")
  boards << board

  # Crear un array con todos los nombres de los estados
  state_names = ["To Do", "In Progress", "Done"]

  # Crear estados para cada tablero
  state_names.each do |state_name|
    board.states.create!(state_name: state_name)
  end

  # Crear tareas en cada tablero
  5.times do |k|
    task = Task.new(
      board_id: board.id,
      state_id: board.states.sample.id,
      title: "Task #{k + 1} for #{board.board_name}",
      description: "Description for Task #{k + 1}",
      informer_id: User.pluck(:id).sample,
      assignee_id: User.pluck(:id).sample,
      status: ["To Do", "In Progress", "Done"].sample,
      priority: rand(1..5)
    )

    task.save!
  end
end

ENV.delete('SEEDING')
