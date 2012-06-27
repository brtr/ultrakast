class User < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  
  attr_accessible :email, :name, :password, :password_confirmation, :category_ids
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def feed
    Post.where("(user_id = ? OR user_id IN (?)) AND category_id in (?)", id, friends, categories)
  end
  
  def public_feed
    Post.where("category_id in (?) AND (shared = ? OR user_id IN (?))", categories, true, id)
  end

  
  
  private
    def create_remember_token
	  self.remember_token = SecureRandom.urlsafe_base64
	end

  
end
