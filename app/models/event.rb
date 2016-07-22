class Event < ApplicationRecord
  include HTTParty

  def self.list(options)
    query = options.gsub(' ','+').downcase
    performer_hash = HTTParty.get("https://api.seatgeek.com/2/performers?q=#{query}")
    performer_id = performer_hash["performers"].first["id"] if performer_hash["performers"]
    results_hash = HTTParty.get("https://api.seatgeek.com/2/events?performers[home_team].id=#{performer_id}&per_page=100")
    parse_results(results_hash['events'])
  end

  def self.parse_results(results)
    results.map do |result|
      home = ""
      away = ""
      result["performers"].each do |team|
        home = team["name"] if team['home_team']
        away = team["name"] if team['away_team']
      end
      { home_team: home,
        away_team: away,
        venue: result["venue"]["name"],
        date: Date.parse(result["datetime_local"]).to_s,
        time: Time.parse(result["datetime_local"]).strftime("%I:%M%p"),
        sport: result["type"]
      }
    end
  end
end
