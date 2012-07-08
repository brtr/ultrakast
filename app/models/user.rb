class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_and_belongs_to_many :categories
  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many   :post_actions
  has_many   :likes
  has_many   :favorites
  has_many   :comments
  has_many   :readings
  
  acts_as_reader
  
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :category_ids
  
  before_save { |user| user.email = email.downcase }

  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name,  presence: true

  
  def feed(status, categories=Category.all)
    if status == "public"
	    Post.where("category_id in (?) AND (shared = ? OR user_id IN (?))", categories, true, id)
	  elsif status == "private"
	    Post.where("(user_id = ? OR user_id IN (?)) AND category_id in (?)", id, friends, categories)
	  end
  end



  
end
