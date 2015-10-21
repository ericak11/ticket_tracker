class TicketsController < ApplicationController
  before_filter :find_ticket, only: [:edit]

  def edit
  end

  def update
    binding.pry
  end

  def mass_update
  end

  def mass_edit
  end

  private
  def find_ticket
    @ticket = Ticket.find(params["id"])
  end
end
