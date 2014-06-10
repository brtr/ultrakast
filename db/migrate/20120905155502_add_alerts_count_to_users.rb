class AddAlertsCountToUsers < ActiveRecord::Migration
  def change

    add_column :users, :alerts_count, :integer, :default => 0
	
	  User.reset_column_information
	  User.find_each do |u|
	    User.reset_counters u.id, :alerts
	  end

  end
end
