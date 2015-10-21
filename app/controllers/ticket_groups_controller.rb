class TicketGroupsController < ApplicationController
  before_filter :find_ticket_group, only: [:show, :update]
  before_filter :find_ticket_groups, only: [:mass_add]

  def index
    @ticket_groups = TicketGroup.all.order(date: :asc)
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    @ticket_group.update(notes_update(params["ticket_group"]))
    redirect_to action: :show
  end

  def destroy
  end

  def create
    @ticket_groups = []

    params["num_tgs"].to_i.times {@ticket_groups << TicketGroup.create(get_tg_params)}
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
  def get_tg_params
    { venue: params["venue"],
      sport: params["sport"],
      home_team: params["home_team"],
      time: params["time"]
    }
  end
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
  def notes_update(tg_params)
    { notes: tg_params["notes"]
    }
  end
end

