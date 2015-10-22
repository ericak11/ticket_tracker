class TicketGroup < ActiveRecord::Base
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :tickets

  def self.sports
    ['Hockey', 'Football']
  end

  def all_tickets_sold
    self.tickets.each do |ticket|
      return false unless ticket.sold == true
    end
    true
  end
end
