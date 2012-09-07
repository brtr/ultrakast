class AddColumnsToAlerts < ActiveRecord::Migration
  def change
	add_column :alerts, :friend_id, :integer
  end
end
