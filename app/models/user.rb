class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  
  #Pass options to devise call - this was moved to config/initializers/devise.rb to prevent conflict with acts-as-readable extension of User class
  @devise_options = [:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :category_ids, :uid, :provider
  
  has_and_belongs_to_many :categories
  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many   :post_actions
  has_many   :likes
  has_many   :favorites
  has_many   :comments

  before_save { |user| user.email = email.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name,  presence: true

  def feed(status, categories)
    if status == "public"
	    Post.where("category_id in (?) AND (shared = ? OR user_id = ?)", categories, true, id)
	  elsif status == "private"
	    Post.where("(user_id = ? OR user_id IN (?)) AND category_id in (?)", id, friends, categories)
	  end

  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end

end
