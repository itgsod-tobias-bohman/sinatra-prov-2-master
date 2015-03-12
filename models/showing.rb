class Showing

  include DataMapper::Resource

  property :id, Serial
  property :start_time, String, required: true

  belongs_to :movie
  belongs_to :cinema
  belongs_to :room

end