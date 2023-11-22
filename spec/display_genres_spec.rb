require_relative '../classes/music/genre'
require_relative '../modules/music/displaygenre'

RSpec.describe DisplayGenres do
  let(:dummy_class) { Class.new { include DisplayGenres } }
  let(:genres) do
    [double(name: 'Genre 1'), double(name: 'Genre 2')]
  end

  before do
    @dummy_instance = dummy_class.new
    @dummy_instance.instance_variable_set(:@genres, genres)
  end

  describe '#display_all_genres' do
    it 'displays all genres with their index and name' do
      expect do
        @dummy_instance.display_all_genres
      end.to output("0) Genre Name: Genre 1\n1) Genre Name: Genre 2\n").to_stdout
    end
  end
end
