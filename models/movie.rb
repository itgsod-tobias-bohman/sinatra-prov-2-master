class Movie

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :runtime, String, required: true

  has n, :showings

end