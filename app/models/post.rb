class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  attr_accessible :content, :category_id
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
end
