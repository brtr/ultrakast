class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
end
