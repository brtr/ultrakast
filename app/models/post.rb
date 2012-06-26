class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  attr_accessible :content, :category_id, :shared
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
  
  scope :shared, where(:shared => true)
  
  def self.by_categories(categories)
    where("category_id in (?)", categories)
  end
  
  
  def root_category_list
    Category.roots.sort_by { |category| category.name }
  end
  
end


