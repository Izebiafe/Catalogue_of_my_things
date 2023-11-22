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
end
