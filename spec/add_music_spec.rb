def test_add_music
  # Arrange
  mock_input_date = '01/01/2022'
  mock_input_on_spotify = 1
  mock_genre_name = 'Rock'

  # Stubbing input methods
  AddMusic.stub(:input_date, mock_input_date) do
    AddMusic.stub(:input_on_spotify, mock_input_on_spotify) do
      AddMusic.stub(:add_genre, mock_genre_name) do
        # Act
        # Call the add_music method

        # Assert
        # Write your assertions here to check if the method behaves as expected
      end
    end
  end
end
