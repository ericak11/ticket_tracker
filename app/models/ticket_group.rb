class TicketGroup < ActiveRecord::Base
  has_many :tickets

  accepts_nested_attributes_for :tickets

  def self.sports
    ['Hockey', 'Football']
  end
end
