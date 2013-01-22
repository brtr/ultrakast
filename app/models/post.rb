class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :category
  
  has_many   :post_actions, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :comments, dependent: :destroy

  attr_accessible :content, :category_id, :shared, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :original_post
  validates :user_id, presence: true
  validates :category_id, presence: true
  
  has_attached_file :image,
    :styles => { :normal => "250", :large => "450" }, 
	  :storage => :s3,
	  :s3_credentials => "#{Rails.root}/config/s3.yml",
	  :path => ":attachment/:id/:style.:extension",
	  :bucket => "ultrakast-dev"
  
  scope :shared, lambda { |user| where("shared = ? OR user_id = ?", true, user) unless user.nil? }
  scope :by_users, lambda { |users| where("user_id IN (?)", users) unless users.nil? }
  scope :by_categories, lambda { |categories| where("category_id IN (?)", categories) unless categories.nil? }
  scope :favorites, lambda { |user| where("id IN (?)", User.find(user).favorites.collect(&:post_id)) unless user.nil? }
  scope :since, lambda { |date| where("updated_at > ?", date) unless date.nil? }
  scope :popular, order("posts.post_actions_count desc")
  scope :recent, order("posts.created_at DESC")
  scope :with_tagged_user, lambda { |name| where("content LIKE ?", "%#{name}%") unless name.nil? } 
  
  #TODO: REFACTOR UNREAD FUNCTIONALITY
  #ideas to make this better?
  #have unread check done at parent level, pass back array of counts, somehow add them to the child links? (dictionary with cat ID as key?)
  #store these counts somewhere with last post time and don't refresh unless new post is made?
  
  def self.unread_count(user, category)
	  #Collect user's friends. No friends? No count. Exit
	  if user.friends.count == 0
	    0
	  else
	    friends = user.friends
	  end

	  if category.ancestry.nil?
	    cat_ids = user.categories.ids & category.children.ids
	  else
	    cat_ids = [category.id]
	  end
	  
	  unread = 0
	  cat_ids.each do |c|
	    #Check last time category was "read" - set read time to now if it does not exist
	    read_time = ReadStatus.where("user_id = ? AND category_id = ?", user.id, c).first
	    if read_time.nil?
	      read_time = ReadStatus.create!(:user_id => user.id, :category_id => c, :last_read_time => Time.now)
	    end
	    unread = unread + by_users(friends).since(read_time.last_read_time).by_categories(c).count
	  end
	
	  unless unread == 0
      if unread < 21
        unread.to_s
      else
        "20+"
      end
	  else
	    0
	  end
  end
end