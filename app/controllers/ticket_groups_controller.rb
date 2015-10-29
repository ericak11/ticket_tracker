class TicketGroupsController < ApplicationController
  before_filter :find_ticket_group, only: [:show, :update, :edit]
  before_filter :find_ticket_groups, only: [:mass_add]

  def index
    @ticket_groups = TicketGroup.all.order(date: :asc)
    @new_ticket_group = TicketGroup.new
    @new_ticket = Ticket.new
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
    @ticket_groups = []
    params["num_tgs"].to_i.times {@ticket_groups << TicketGroup.create(ticket_group_params)}
    seats = Array(params["seat_numbers_start"].to_i..params["seat_numbers_end"].to_i)
    ticket_params = get_ticket_params
    @ticket_groups.each do |tg|
      seats.each do |seat|
        Ticket.create(ticket_params.merge({seat: seat, ticket_group_id: tg.id}))
      end
    end
    redirect_to action: :mass_add, ticket_groups: @ticket_groups
  end

  def mass_add
  end

  def mass_edit
    params["ticket_group"].each do |ticket_group|
      TicketGroup.find(ticket_group[0]).update(get_update_params(ticket_group[1]))
    end
    redirect_to action: :index
  end

  private
  def get_ticket_params
    { section: params["section"],
      row: params["row"],
      face_value: params["face_value"],
      use_type: "Personal"
    }
  end
  def get_update_params(tg_params)
    { away_team: tg_params["away_team"],
      date: tg_params["date"],
      notes: tg_params["notes"]
    }
  end
  def find_ticket_group
    @ticket_group = TicketGroup.find(params["id"])
  end
  def find_ticket_groups
    @ticket_groups = TicketGroup.find(params["ticket_groups"])
  end
  def ticket_group_params
    get_params.permit(:notes, :away_team, :home_team, :time, :date, :venue, :sport)
  end
  def get_params
    params[:action] == "create" ? params : params["ticket_group"]
  end
end

