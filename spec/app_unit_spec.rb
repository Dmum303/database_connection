require_relative '../app'

RSpec.describe Application do

    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_artists_table
    end

    it 'checks list all albums works' do
        io = double :io
        expect(io).to receive(:puts).with('* 1 - Doolittle')
        expect(io).to receive(:puts).with('* 2 - Waterloo')
        run_app = Application.new('music_library_test', io, 'lib/album_repository', 'lib/Artist_repository')
        run_app.list_all_albums
    end

    it 'checks list all artists works' do
        io = double :io
        expect(io).to receive(:puts).with('* 1 - Pixies')
        expect(io).to receive(:puts).with('* 2 - ABBA')
        run_app = Application.new('music_library_test', io, 'lib/album_repository', 'lib/Artist_repository')
        run_app.list_all_artists
    end
    
    it 'checks menu system' do
        io = double :io
        expect(io).to receive(:puts).with('What would you like to do?')#.ordered
        expect(io).to receive(:puts).with('1 - List all albums')#.ordered
        expect(io).to receive(:puts).with('2 - List all artists')#.ordered
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with('* 1 - Doolittle')
        expect(io).to receive(:puts).with('* 2 - Waterloo')
        run_app = Application.new('music_library_test', io, 'lib/album_repository', 'lib/Artist_repository')
        run_app.run
    end

    it 'checks menu system' do
        io = double :io
        expect(io).to receive(:puts).with('What would you like to do?')#.ordered
        expect(io).to receive(:puts).with('1 - List all albums')#.ordered
        expect(io).to receive(:puts).with('2 - List all artists')#.ordered
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with('* 1 - Pixies')
        expect(io).to receive(:puts).with('* 2 - ABBA')
        run_app = Application.new('music_library_test', io, 'lib/album_repository', 'lib/Artist_repository')
        run_app.run
    end

    it 'checks any other input' do 
        io = double :io
        expect(io).to receive(:puts).with('What would you like to do?')#.ordered
        expect(io).to receive(:puts).with('1 - List all albums')#.ordered
        expect(io).to receive(:puts).with('2 - List all artists')#.ordered
        expect(io).to receive(:gets).and_return("g")
        expect(io).to receive(:puts).with('Please be sensible')
        expect(io).to receive(:puts).with('What would you like to do?')#.ordered
        expect(io).to receive(:puts).with('1 - List all albums')#.ordered
        expect(io).to receive(:puts).with('2 - List all artists')#.ordered
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with('* 1 - Pixies')
        expect(io).to receive(:puts).with('* 2 - ABBA')
        run_app = Application.new('music_library_test', io, 'lib/album_repository', 'lib/Artist_repository')
        run_app.run
    end
end