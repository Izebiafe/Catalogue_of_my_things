require 'rspec'
require_relative '../modules/music/displaymusic'

RSpec.describe DisplayMusic do
  let(:dummy_class) { Class.new { include DisplayMusic } }
  let(:music_albums) do
    [
      double('MusicAlbum', on_spotify: true, publish_date: '01/01/2022', genre: double('Genre', name: 'Rock')),
      double('MusicAlbum', on_spotify: false, publish_date: '02/01/2022', genre: nil)
    ]
  end

  before do
    @dummy_instance = dummy_class.new
    @dummy_instance.instance_variable_set(:@music_albums, music_albums)
  end

  describe '#display_all_music_albums' do
    it 'displays all music albums with their index, on_Spotify status, publish date, and genre' do
      expect do
        @dummy_instance.display_all_music_albums
      end.to output("0) on_Spotify: true, Publish Date: 01/01/2022 Genre: Rock\n1)
       on_Spotify: false, Publish Date: 02/01/2022 Genre: N/A\n").to_stdout
    end
  end
end
