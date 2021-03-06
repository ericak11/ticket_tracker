class TicketGroupsController < ApplicationController
  before_filter :get_ticket_group, only: [:show, :update, :edit]

  def index
    @filters = params[:filter] || {}
    find_ticket_groups
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    @ticket_group.update(ticket_group_params)
    redirect_to action: :show
  end

  def destroy
  end

  def create
    query_string ="#{params[:ticket_group][:home_team]} #{params[:ticket_group][:sport]}"
    @events = Event.list(query_string)
    create_ticket_groups
    seats = Array(params[:ticket_group][:ticket]["seat_numbers_start"].to_i..params[:ticket_group][:ticket]["seat_numbers_end"].to_i)
    ticket_params = get_ticket_params
    @ticket_groups.each do |tg|
      seats.each do |seat|
        Ticket.create(ticket_params.merge({seat: seat, ticket_group_id: tg.id}))
      end
    end
    redirect_to action: :index
  end

  def mass_edit
    params["ticket_group"].each do |ticket_group|
      TicketGroup.find(ticket_group).update(get_update_params(ticket_group))
    end
    redirect_to action: :index
  end

  private
  def get_ticket_params
    { section: params["section"],
      row: params["row"],
      face_value: params["face_value"],
      use_type: "Unlisted"
    }
    params[:ticket_group][:ticket].permit(:section, :row, :face_value, :use_type)
  end

  def get_update_params(tg_param_number)
    tg_params = params["ticket_group"][tg_param_number.to_s].permit(:notes, :away_team, :date)
    { away_team: tg_params["away_team"],
      date: tg_params["date"],
      notes: tg_params["notes"]
    }
  end

  def get_ticket_group
    @ticket_group = TicketGroup.find(params["id"])
    my_tickets?(@ticket_group.id)
  end

  def ticket_group_params
    params["ticket_group"].permit(:notes, :away_team, :home_team, :time, :date, :venue, :sport, :user_id)
  end

  def find_ticket_groups
    p = params[:filter].present? ? params[:filter].reject{|key, value|  value == "0" || value == ""} : {}
    current_ticket_groups = TicketGroup.where(user_id: current_user.id).order(date: :asc)
    if !p.empty?
      (current_ticket_groups = current_ticket_groups.where(sport: p[:sport])) && p.delete("sport") if p[:sport].present?
      (current_ticket_groups = current_ticket_groups.where("date >= ?", Date.today)) && p.delete("future_events") if p[:future_events].present?
      (current_ticket_groups = current_ticket_groups.where("date < ?", Date.today)) && p.delete("past_events") if p[:past_events].present?
      if p[:sold_tickets].present?|| p[:listed_tickets].present? || p[:unlisted_tickets].present? || p[:personal].present? || p[:business].present? || p[:unused].present?
        filter_use_types = create_use_type_array(p)
        current_ticket_groups = current_ticket_groups.select do |current_ticket_group|
          !(current_ticket_group.use_types & filter_use_types).empty?
        end
      end
    end
    @ticket_groups = current_ticket_groups
  end

  def create_use_type_array(p)
    use_type_array = ['Personal', 'Business', 'For Sale', 'Sold', 'Unused', 'Unlisted']
    use_type_array.delete("Personal") unless p[:personal].present?
    use_type_array.delete("Business") unless p[:business].present?
    use_type_array.delete("For Sale") unless p[:listed_tickets].present?
    use_type_array.delete("Sold") unless p[:sold_tickets].present?
    use_type_array.delete("Unused") unless p[:unused].present?
    use_type_array.delete("Unlisted") unless p[:unlisted_tickets].present?
    use_type_array
  end

  def create_ticket_groups
    @ticket_groups = []
    @events.each do |event|
      tg = TicketGroup.find_or_initialize_by(event.merge({user_id: params[:ticket_group][:user_id]}))
      unless tg.id.present?
        tg.save
        @ticket_groups << tg
      end
    end
  end
end
