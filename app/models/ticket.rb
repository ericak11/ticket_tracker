class Ticket < ActiveRecord::Base
  belongs_to :ticket_group
  attr_accessor :seat_numbers_start, :seat_numbers_end
  def self.use_types
    ['Personal', 'Business', 'For Sale', 'Sold', 'Unused']
  end

end
