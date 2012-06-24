class Category < ActiveRecord::Base
  has_ancestry
  has_and_belongs_to_many :users
  has_many :posts

  attr_accessible :name, :parent_id
  

end
