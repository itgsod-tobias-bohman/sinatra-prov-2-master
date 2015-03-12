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

    slim :times
  end

  get '/movie/:movie/' do |movie|
    @movie = Movie.first(:name => "#{movie}")
    slim :movie
  end

end