class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login
  before_filter :get_new_ticket_info
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_new_ticket_info
    @new_ticket_group = TicketGroup.new
    @new_ticket = Ticket.new
  end
  def my_tickets?(tg_id)
    tg = TicketGroup.find(tg_id)
    unless tg.user_id == current_user.id
      deny_access(I18n.t("flashes.failure_when_not_signed_in"))
    end
  end
end
