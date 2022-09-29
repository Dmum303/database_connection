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

    it 'Returns the ABBA as single artist' do
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

    it 'deletes an artist' do
        repo = ArtistRepository.new

        id_to_delete = 1 
        repo.delete(id_to_delete)

        all_artists = repo.all
        expect(all_artists.length).to eq 1
        expect(all_artists.first.id).to eq '2'
        
    end

    it 'deletes the two artists' do
        repo = ArtistRepository.new

        repo.delete(1)
        repo.delete(2)

        all_artists = repo.all
        expect(all_artists.length).to eq(0)
    end

    it 'Updates an artist with new values' do
        repo = ArtistRepository.new

        artist = repo.find(1) 
        artist.name = 'Something else'
        artist.genre = 'Disco'

        repo.update(artist)

        updated_artist = repo.find(1)

        expect(updated_artist.name).to eq 'Something else'
        expect(updated_artist.genre).to eq 'Disco'
    end

    it 'Updates an artist with only one value' do
        repo = ArtistRepository.new

        artist = repo.find(2) 
        artist.name = 'Something else 2'


        repo.update(artist)

        updated_artist = repo.find(2)

        expect(updated_artist.name).to eq 'Something else 2'
        expect(updated_artist.genre).to eq 'Pop'
    end

end