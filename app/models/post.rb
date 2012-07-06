class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  has_many   :post_actions
  has_many   :likes
  has_many   :favorites
  
  acts_as_readable
  
  attr_accessible :content, :category_id, :shared
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
  validates :category_id, presence: true
  
  scope :shared, where(:shared => true)
  
  def self.by_categories(categories)
    where("category_id in (?)", categories)
  end
  
  def self.unread_count(user, categories)
    unread = by_categories(categories).find_unread_by(user).count
	
	unless unread == 0
	  "(" + unread.to_s + " new)"
	end
	
	
  end

  
end


