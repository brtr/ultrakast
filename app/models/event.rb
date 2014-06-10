class Event < ActiveRecord::Base
	belongs_to :category

  attr_accessible :category_id, :start_time, :title
end
