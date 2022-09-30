# file: app.rb

require_relative 'lib/database_connection.rb'
require_relative 'lib/Artist_repository'
require_relative 'lib/album_repository'


class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end   

  def run
    @io.puts 'What would you like to do?'
    @io.puts '1 - List all albums'
    @io.puts '2 - List all artists'
    input = @io.gets.chomp
    if input == '1'
    list_all_albums
    elsif input == '2'
       list_all_artists
    else
       @io.puts 'Please be sensible'
       run
    end
  end

  def list_all_albums
    repo = AlbumRepository.new
    album_list = repo.all
    album_list.each do |album|
      @io.puts "* #{album.id} - #{album.title}"
    end
  end

  def list_all_artists
    repo = ArtistRepository.new
    artist_list = repo.all
    artist_list.each do |artist|
      @io.puts "* #{artist.id} - #{artist.name}"
    end
  end
# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
  if __FILE__ == $0
    app = Application.new(
      'music_library',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end

end


# I would thin I need to call the class with all the parameters required 
#in the initialize
# We need to give the database name to the method `connect`.
# DatabaseConnection.connect('music_library')

#This code not needed as now in Artist_repository file
# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

# artist_repository = ArtistRepository.new

# # p artist_repository.all

# # Cleaner output
# # artist_repository.all.each do |artist|
# #     p artist
# # end

# artist = artist_repository.find(1)
# puts artist.name
# album_repository = AlbumRepository.new

# album = album_repository.find(1)
# puts album.title