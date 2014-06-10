class Tutor < ActiveRecord::Base
  attr_accessible :email, :name, :phone
  has_and_belongs_to_many :categories

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		tutor = self.create name: row[0], email: row[1], phone: row[2]

  		row[3..row.length].each do |category_name|
  			category = Category.where(name: category_name.strip).first
	  		tutor.categories << category unless category.blank?
	  	end
  	end
  end
end
