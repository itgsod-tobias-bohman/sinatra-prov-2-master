class App < Sinatra::Base

  get '/' do
    @movies = Movie.all(:order => [:name.asc])
    @cinemas = Cinema.all(:order => [:name.asc])
    slim :index
  end

  get '/cinema/:cinema/' do |cinema|
    @cinema = Cinema.first(:name => "#{cinema}")

    @showings = Showing.all(:cinema_id => "#{@cinema.id}", :order => [:movie_id.asc])

    movie_list = []
    @showings.each do |x|
      movie_list << x.movie_id
    end
    movie_list = movie_list.uniq

    @movies = []
    movie_list.each do |x|
      @movies << Movie.all(:id => x)
    end

    slim :cinema
  end

  get '/cinema/:cinema/:movie' do |cinema, movie|
    @cinema = Cinema.first(:name => "#{cinema}")
    @movie = Movie.first(:name => "#{movie}")

    @times = Showing.all(:cinema_id => "#{@cinema.id}", :movie_id => "#{@movie.id}")

    room_list = []
    @times.each do |x|
      room_list << x.room_id
    end

    @rooms = []
    room_list.each do |x|
      @rooms << Room.all(:id => x)
    end

    slim :times
  end

  get '/movie/:movie/' do |movie|
    @movie = Movie.first(:name => "#{movie}")

    @showings = Showing.all(:movie_id => "#{@movie.id}", :order => [:cinema_id.asc])

    cinema_list = []
    @showings.each do |x|
      cinema_list << x.cinema_id
    end
    cinema_list = cinema_list.uniq

    @cinemas = []
    cinema_list.each do |x|
      @cinemas << Cinema.all(:id => x)
    end

    slim :movie
  end

end