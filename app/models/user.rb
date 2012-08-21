class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  
  #Pass options to devise call - this was moved to config/initializers/devise.rb to prevent conflict with acts-as-readable extension of User class
  @devise_options = [:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :category_ids, :uid, :provider, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at
  
  has_and_belongs_to_many :categories
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships, dependent: :destroy

  has_many   :post_actions, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :comments, dependent: :destroy

  before_save { |user| user.email = email.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name,  presence: true


  has_attached_file :avatar,
    :styles => { :square => "50x50^", :small => "50", :normal => "100", :large => "200" }, 
	:convert_options => { :square => "-gravity center -extent 50x50" },
	:storage => :s3,
	:s3_credentials => "#{Rails.root}/config/s3.yml",
	:path => ":attachment/:id/:style.:extension",
	:bucket => "ultrakast_images"
  

  def feed(status, categories, sort)
    if status == "public"
	  posts = Post.shared(id)
	else
	  ((users = []) << id << friend_ids).flatten!
	  posts = Post.by_users(users)
	end
    
    unless categories == "all"
      posts = posts.by_categories(categories)
    end

    if sort == "popular"
      posts = posts.popular
    else
	  posts = posts.recent
	end

	posts.includes(:user, {:comments => :user}, :category)

  end

#    if status == "public"
#	  if categories == "all"
#	    Post.where("shared = ? OR user_id = ?", true, id).includes(:user, {:comments => :user}, :category)
#      else
#	    Post.where("category_id in (?) AND (shared = ? OR user_id = ?)", categories, true, id).includes(:user, {:comments => :user}, :category)
#	  end
#	elsif status == "private"
#	  if categories == "all"
#	    Post.where("user_id = ? OR user_id IN (?)", id, friends).includes(:user, {:comments => :user}, :category)
#	  else
#		Post.where("(user_id = ? OR user_id IN (?)) AND category_id in (?)", id, friends, categories).includes(:user, {:comments => :user}, :category)
#	  end
#	end
# end
  
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
