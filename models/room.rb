class Room

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :number_of_seats, String, required: true

  belongs_to :cinema
  has n, :showings

end