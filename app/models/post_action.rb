class PostAction < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :post_id, :user_id
  
  #RYO counter cache to deal with STI
  after_create :increment_counts
  before_destroy :decrement_counts
  
  protected
  #Increment and decrement STI type count (ex: likes_count) and post_actions_count (used to order for popularity sort)
  
    def increment_counts
	    Post.increment_counter "#{type.pluralize.underscore}_count", post_id
	    Post.increment_counter "post_actions_count", post_id
	  end    
	
	  def decrement_counts
	    Post.decrement_counter "#{type.pluralize.underscore}_count", post_id
	    Post.decrement_counter "post_actions_count", post_id
	  end 
end
