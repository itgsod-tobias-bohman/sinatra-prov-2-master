class App < Sinatra::Base

  get '/' do
    @movies = Movie.all(:order => [:name.asc])
    @cinemas = Cinema.all(:order => [:name.asc])
    slim :index
  end

  get '/cinema/:cinema' do |cinema|
    @cinema = Cinema.first(:name => "#{cinema}")

    @showings = Showing.all(:cinema_id => "#{@cinema.id}", :fields => [:movie_id], :unique => true, :order => [:movie_id.asc])

    @showings.inspect
    #slim :cinema
  end

  get '/movie/:movie' do |movie|
    @movie = Movie.first(:name => "#{movie}")
    slim :movie
  end

end