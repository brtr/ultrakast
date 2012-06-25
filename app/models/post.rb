class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  attr_accessible :content, :category_id
  default_scope order: 'posts.created_at DESC'
  validates :user_id, presence: true
  
  def category_list
    category_array = []
    Category.roots.sort_by { |category| category.name }.each do |category|
      category_array.push(category)
      category.children.each do |sub|
        category_array.push(sub)
      end
    end
    category_array
  end
end
