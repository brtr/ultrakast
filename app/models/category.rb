class Category < ActiveRecord::Base
  has_ancestry
  has_and_belongs_to_many :users
  has_many :posts
<<<<<<< HEAD
  has_and_belongs_to_many :tutors
  has_many :events
=======
>>>>>>> 0a402916808b80e5eebd82882d838f99776a10a6

  attr_accessible :name, :parent_id
  
 
  def child_categories_for(user_id)
    user = User.find(user_id)
	  self.children.where("id IN (?)", user.categories).sort_by { |child| child.id }
  end
  
  def return_filtered_categories(categories)
    self.children.where("id IN (?)", categories).sort_by { |child| child.id }
  end
  
  def self.ids
    all.collect { |cat| cat.id }
  end
end