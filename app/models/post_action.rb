class PostAction < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :post_id, :user_id
  
  after_create :increment_counts
  before_destroy :decrement_counts
  
  protected
    def increment_counts
	  Post.increment_counter "#{type.pluralize.underscore}_count", post_id
	end    
	
	def decrement_counts
	  Post.decrement_counter "#{type.pluralize.underscore}_count", post_id
	end 
end
