class AddFriendsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends_count, :integer, :default => 0
	
	  User.reset_column_information
  	User.find_each do |u|
	    User.reset_counters u.id, :friendships
  	end
  end
end
