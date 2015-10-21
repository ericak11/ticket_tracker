class CreateTicketGroup < ActiveRecord::Migration
  def change
    create_table :ticket_groups do |t|
      t.string :date
      t.string :time
      t.string :venue
      t.string :sport
      t.text :notes
      t.string :home_team
      t.string :away_team

      t.timestamps
    end
  end
end
