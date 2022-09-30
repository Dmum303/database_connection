{{PROBLEM}} Method Design Recipe
1. Describe the Problem
$ ruby app.rb

Welcome to the music library manager!

What would you like to do?
 1 - List all albums
 2 - List all artists

Enter your choice: 1
[ENTER]

Here is the list of albums:
 * 1 - Doolittle
 * 2 - Surfer Rosa
 * 3 - Waterloo
 * 4 - Super Trouper
 * 5 - Bossanova
 * 6 - Lover
 * 7 - Folklore
 * 8 - I Put a Spell on You
 * 9 - Baltimore
 * 10 -	Here Comes the Sun
 * 11 - Fodder on My Wings
 * 12 -	Ring Ring

2. Design the Method Signature
Include the name of the method, its parameters, return value, and side effects.

def run
   @io.puts 'What would you like to do?'
   @io.puts '1 - List all albums'
   @io.puts '2 - List all artists'
   input = @io.gets.chomp
   if input == '1'
      list_all-albums
   elsif input == '2'
      list_all_artists
   # else
   #    @io.puts 'Please be sensible'
   #    run
   end
end
    
def list_all_albums
  repo = AlbumRepository.new
  album_list = repo.all
  album_list.each_with_index do |album, index|
    puts "#{index} - #{album.title} - #{album.release_year}"
  end
end

def list_all_artists
   repo = ArtistRepository.new
   artist_list = repo.all
   artist_list.each_with_index do |artist, index|
     puts "#{index} - #{artist.name} - #{artist.genre}"
   end
end


# The method doesn't print anything or have any other side-effects
3. Create Examples as Tests
Make a list of examples of what the method will take and return.

# EXAMPLE
# testing run behavior
terminal = double :terminal
expect(terminal).to receive(:puts).with('What would you like to do?')#.ordered
expect(terminal).to receive(:puts).with('1 - List all albums')#.ordered
expect(terminal).to receive(:puts).with('2 - List all artists')#.ordered
expect(terminal).to receive(:gets).and_return("1")#.ordered
# expect(terminal).to receive(:puts).with("Please enter another number")#.ordered
# expect(terminal).to receive(:gets).and_return("3")#.ordered

terminal = double :terminal
expect(terminal).to receive(:puts).with('What would you like to do?')#.ordered
expect(terminal).to receive(:puts).with('1 - List all albums')#.ordered
expect(terminal).to receive(:puts).with('2 - List all artists')#.ordered
expect(terminal).to receive(:gets).and_return("2")#.ordered



extract_uppercase("hello WORLD") => ["WORLD"]
extract_uppercase("HELLO WORLD") => ["HELLO", "WORLD"]
extract_uppercase("hello world") => []
extract_uppercase("hello WoRLD") => []
extract_uppercase("hello WORLD!") => ["WORLD"]
extract_uppercase("") => []
extract_uppercase(nil) throws an error
Encode each example as a test. You can add to the above list as you go.

4. Implement the Behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.