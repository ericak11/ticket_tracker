class AddUserIdToTicketGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :ticket_groups, :user_id, :integer
  end
end
