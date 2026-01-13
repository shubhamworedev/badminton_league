# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create players
players = [
  "Alice Johnson",
  "Bob Smith",
  "Charlie Brown",
  "Diana Prince",
  "Ethan Hunt",
  "Fiona Apple",
  "George Wilson",
  "Hannah Montana"
].map { |name| Player.find_or_create_by!(name: name) }

# Create matches with various winners and losers
matches_data = [
  { winner: players[0], loser: players[1] },  # Alice beats Bob
  { winner: players[1], loser: players[2] },  # Bob beats Charlie
  { winner: players[3], loser: players[4] },  # Diana beats Ethan
  { winner: players[5], loser: players[6] },  # Fiona beats George
  { winner: players[0], loser: players[3] },  # Alice beats Diana
  { winner: players[2], loser: players[5] },  # Charlie beats Fiona
  { winner: players[4], loser: players[7] },  # Ethan beats Hannah
  { winner: players[6], loser: players[1] },  # George beats Bob
  { winner: players[3], loser: players[2] },  # Diana beats Charlie
  { winner: players[0], loser: players[7] },  # Alice beats Hannah
]

matches_data.each do |match_data|
  Match.find_or_create_by!(
    winner_id: match_data[:winner].id,
    loser_id: match_data[:loser].id
  )
end

puts "Seed data created successfully!"
puts "Players: #{Player.count}"
puts "Matches: #{Match.count}"