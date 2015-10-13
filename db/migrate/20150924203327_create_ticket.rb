class CreateTicket < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :seat
      t.string :row
      t.string :section
      t.decimal :sale_price
      t.string :use_type
      t.decimal :face_value
      t.integer :ticket_group_id
      t.text :notes
      t.string :user
      t.boolean :sold

      t.timestamps
    end
  end
end
