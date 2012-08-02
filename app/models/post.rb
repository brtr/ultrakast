class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :category
  
  has_many   :post_actions, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :comments, dependent: :destroy

  attr_accessible :content, :category_id, :shared
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
  validates :category_id, presence: true
  
  scope :shared, where(:shared => true)
  
  
  # ENTIRE UNREAD FUNCTIONALITY NEEDS TO BE REWORKED FROM SCRATCH
  #acts_as_readable
  #Get count of unread posts, sorted by category, posted by a user's friends
  #Returns a string showing number of new posts to append to the category links
  #def self.unread_count(user, categories)
  #  unread = where("category_id in (?) AND posts.user_id in (?)", categories, user.friends).find_unread_by(user).count
  #  unless unread == 0
  #    "(" + unread.to_s + " new)"
  #  end
  #end
 
end


