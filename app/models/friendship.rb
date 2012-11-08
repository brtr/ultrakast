class Friendship < ActiveRecord::Base
 
  attr_accessible :friend_id, :user_id
  
  belongs_to :user, :counter_cache => "friends_count"
  belongs_to :friend, :class_name => 'User'
end