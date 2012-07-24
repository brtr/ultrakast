class AddFriendsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends_count, :integer, :default => 0
	
	User.reset_column_information
	User.all.each do |u|
	  u.update_attribute :friends_count, u.friends.length
	end
  end
end
