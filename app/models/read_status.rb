class ReadStatus < ActiveRecord::Base
  attr_accessible :user_id, :category_id, :last_read_time
end
