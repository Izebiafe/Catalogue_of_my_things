require 'json'
require_relative '../modules/music/storage'

RSpec.describe Storage do
  let(:dummy_class) { Class.new { include Storage } }

  before do
    @dummy_instance = dummy_class.new
    @dummy_instance.instance_variable_set(:@music_albums, [])
    @dummy_instance.instance_variable_set(:@genres, [])
  end

  describe '#save_file' do
    it 'saves the data to the specified file' do
      file_name = 'test_data.json'
      data = { key: 'value' }
      @dummy_instance.save_file(file_name, data)

      expect(File.exist?(file_name)).to be true
      loaded_data = JSON.parse(File.read(file_name), symbolize_names: true)
      expect(loaded_data).to eq(data)

      # Clean up the test file
      File.delete(file_name)
    end
  end

  describe '#save_music' do
    it 'saves the music albums and genres' do
      # Add some test data to the music albums and genres arrays
      music_album = instance_double('MusicAlbum',
                                    to_hash: { id: 1, publish_date: '2022-01-01', on_spotify: true, genre: 'Rock' })
      genre = instance_double('Genre', to_hash: { name: 'Rock', id: 1 })
      @dummy_instance.instance_variable_get(:@music_albums) << music_album
      @dummy_instance.instance_variable_get(:@genres) << genre

      # Call the method
      @dummy_instance.save_music

      # Check if the music albums and genres files were saved
      expect(File.exist?('data/music_albums.json')).to be true
      expect(File.exist?('data/genres.json')).to be true

      # Clean up the test files
      File.delete('data/music_albums.json')
      File.delete('data/genres.json')
    end
  end
end
