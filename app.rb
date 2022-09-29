# file: app.rb

require_relative 'lib/database_connection.rb'
require_relative 'lib/Artist_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

#This code not needed as now in Artist_repository file
# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

artist_repository = ArtistRepository.new

# p artist_repository.all

# Cleaner output
# artist_repository.all.each do |artist|
#     p artist
# end

artist = artist_repository.find(4)
puts artist.name