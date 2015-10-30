class ApplicationController < ActionController::Base
  before_filter :get_new_ticket_info
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_new_ticket_info
    @new_ticket_group = TicketGroup.new
    @new_ticket = Ticket.new
  end
end
