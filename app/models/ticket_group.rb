class TicketGroup < ApplicationRecord
  has_many :tickets, dependent: :destroy
  belongs_to :user

  attr_accessor :num_tgs
  accepts_nested_attributes_for :tickets

  def self.sports
    [['Hockey', 'nhl'], ['Football', 'nfl'], ['Basketball', 'nba'], 'Misc']
  end

  def all_tickets_sold
    self.tickets.each do |ticket|
      return false unless ticket.sold == true
    end
    true
  end

  def number_of_tickets_sold
    self.tickets.where(sold: true).count
  end

  def use_types
    tickets.collect(&:use_type).uniq
  end
end
