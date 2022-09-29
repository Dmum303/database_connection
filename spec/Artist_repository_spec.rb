 require 'Artist_repository'

RSpec.describe ArtistRepository do
    
    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_artists_table
    end
    
    it 'returs the list of artists' do

        repo = ArtistRepository.new
        artists = repo.all # the array

        expect(artists.length).to eq(2) #=> 2
        expect(artists.first.id).to eq('1') # => '1'
        expect(artists.first.name).to eq('Pixies') # => 'Pixies'
    end

    it 'Returns the Pixies as single artist' do
        repo = ArtistRepository.new

        artist = repo.find(1)
        expect(artist.name).to eq('Pixies') # => 'Pixies'
        expect(artist.genre).to eq('Rock') # => 'Rock'
    end

    it 'Returns the Pixies as single artist' do
        repo = ArtistRepository.new

        artist = repo.find(2)
        expect(artist.name).to eq('ABBA') # => 'Pixies'
        expect(artist.genre).to eq('Pop') # => 'Rock'
    end

    it 'Creates a new artist' do
        repo = ArtistRepository.new
        artist = Artist.new
        artist.name = 'ABBA GABBA'
        artist.genre = 'Gabber'
        repo.create(artist)
        #check it worked
        artists = repo.all
        last_artist = artists.last
        expect(last_artist.name).to eq 'ABBA GABBA'
        expect(last_artist.genre).to eq 'Gabber'
    end
end