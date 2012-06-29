class Category < ActiveRecord::Base
  has_ancestry
  has_and_belongs_to_many :users
  has_many :posts

  attr_accessible :name, :parent_id
  
  def child_name
    self.children.sort_by { |child| child.name }
  end
  
  def child_name_for(user_id)
    user = User.find(user_id)
	self.children.where("id IN (?)", user.categories).sort_by { |child| child.name }
  end
end
