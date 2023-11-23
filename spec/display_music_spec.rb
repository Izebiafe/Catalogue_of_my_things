require_relative '../modules/music/displaymusic'

RSpec.describe DisplayMusic do
  let(:dummy_class) { Class.new { include DisplayMusic } }
  let(:music_albums) do
    [
      double('MusicAlbum', on_spotify: true, publish_date: '2022-01-01', genre: double('Genre', name: 'Rock')),
      double('MusicAlbum', on_spotify: false, publish_date: '2022-02-01', genre: nil)
    ]
  end

  before do
    @dummy_instance = dummy_class.new
    @dummy_instance.instance_variable_set(:@music_albums, music_albums)
  end
end
