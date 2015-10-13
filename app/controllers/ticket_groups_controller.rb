class TicketGroupsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
  end

  def mass_add
    @ticket_groups = []

    params["num_tgs"].to_i.times {@ticket_groups << TicketGroup.create(get_tg_params)}
    seats = Array(params["seat_numbers_start"].to_i..params["seat_numbers_end"].to_i)
    ticket_params = get_ticket_params
    @ticket_groups.each do |tg|
      seats.each do |seat|
        Ticket.create(ticket_params.merge({seat: seat, ticket_group_id: tg.id}))
      end
    end
    @event_time = params["event_time"]
  end

  def mass_edit
  end

  private
  def get_tg_params
    { location: params["location"],
      sport: params["sport"],
      home_team: params["home_team"]
    }
  end
  def get_ticket_params
    { section: params["section"],
      row: params["row"],
      face_value: params["face_value"]
    }
  end
end
