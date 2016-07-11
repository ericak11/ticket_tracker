class TicketsController < ApplicationController
  before_filter :find_ticket, only: [:edit, :update]
  before_filter :find_first_ticket, only: [:mass_edit]
  before_filter :find_tickets, only: [:mass_update]

  def edit
  end

  def update
    @ticket.update(ticket_params)
    redirect_to ticket_group_path(@ticket.ticket_group.id)
  end

  def mass_edit
    @ticket_ids = params["ticket_ids"]
  end

  def mass_update
    @tickets.update(ticket_params)
    update_ticket_users(params["ticket"]["user"].split(",")) if params["ticket"]["user"].present?
    redirect_to ticket_group_path(@tickets.first.ticket_group.id)
  end

  private
  def find_ticket
    @ticket = Ticket.find(params["id"])
    my_tickets?(@ticket.ticket_group.id)
  end

  def find_first_ticket
    @ticket = Ticket.find(params["ticket_ids"]).first
  end

  def ticket_params
    params["ticket"].permit(:face_value, :sold, :sale_price, :use_type, :notes, :user).reject!{|key, value| value==""}
  end

  def find_tickets
    ids = params["ticket"].delete :ids
    ticket_ids = ids.split(" ")
    @tickets = Ticket.where(id: ticket_ids).order(seat: :asc)
  end

  def update_ticket_users(users)
    users.each_with_index do |user, index|
      @tickets[index].update(user: user) if @tickets[index].present?
    end
  end
end
