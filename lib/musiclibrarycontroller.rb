class MusicLibraryController

  def initialize(path = "./db/mp3s")
    # @path = path
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    user_input = ""
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.to_s
      if user_input == "list songs"
        list_songs
      elsif user_input == "list artists"
        list_artists
      elsif user_input == "list genres"
        list_genres
      elsif user_input == "list artist"
        list_songs_by_artist
      elsif user_input == "list genre"
        list_songs_by_genre
      elsif user_input == "play song"
        play_song
      end
    end
  end

  def list_songs
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each_with_index do |item, index|
      puts "#{index + 1}. #{item.artist.name} - #{item.name} - #{item.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by {|item| item.name}
    sorted_artists.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by {|item| item.name}
    sorted_genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.to_s
    counter = 1
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each do |songs|
      check = songs.artist.name
      if check == user_input
        puts "#{counter}. #{songs.name} - #{songs.genre.name}"
        counter += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.to_s
    counter = 1
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each do |songs|
      check = songs.genre.name
      if check == user_input
        puts "#{counter}. #{songs.artist.name} - #{songs.name}"
        counter += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list = list_songs
    user_input = gets.strip
    user_index = user_input.to_i - 1
    binding.pry
    if user_input != 0
      puts "Playing #{list[user_index].name} by #{list[user_index].artist.name}."
    end
  end

end
