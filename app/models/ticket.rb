class Ticket < ActiveRecord::Base
  belongs_to :ticket_group

  def self.use_types
    ['Personal', 'Business', 'Sold']
  end

end
