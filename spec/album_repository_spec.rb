require 'album_repository'

RSpec.describe AlbumRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_albums_table
    end

    it 'returs the list of albums' do

        repo = AlbumRepository.new
        albums = repo.all # the array

        expect(albums.length).to eq(2)
        expect(albums.first.id).to eq('1') 
        expect(albums.first.title).to eq('Doolittle')
    end

    it 'Returns the Doolittle as single album' do
        repo = AlbumRepository.new
        
        album = repo.find(1)
        expect(album.title).to eq 'Doolittle'
    end
    

    it 'Creates a new album record' do
        repo = AlbumRepository.new

        album = Album.new
        album.title = 'Trompe le Monde'
        album.release_year = 1991
        album.artist_id = 1

        repo.create(album)

        all_albums = repo.all
        expect(all_albums.length).to eq 3
    end
end

