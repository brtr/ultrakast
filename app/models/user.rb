class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  #, :confirmable
  
  #The below is not in use anymore (along with the corresponding code at the bottom of config/initializers/devise.rb) - leaving it in for reference
  #Pass options to devise call - this was moved to config/initializers/devise.rb to prevent conflict with acts-as-readable extension of User class
  #@devise_options = [:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :category_ids, :uid, :provider, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at
  
  has_many :friends, :through => :friendships, dependent: :destroy, :conditions => ['status = ?', "approved"]
  has_and_belongs_to_many :categories
  has_many :posts,        dependent: :destroy
  has_many :friendships,  dependent: :destroy
  has_many :post_actions, dependent: :destroy
  has_many :likes,        dependent: :destroy
  has_many :favorites,    dependent: :destroy
  has_many :comments,     dependent: :destroy
  has_many :alerts,       dependent: :destroy

  before_save { |user| user.email = email.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name,  presence: true
  validates :last_name,  presence: true
  
  default_scope :order => 'last_name ASC'

  has_attached_file :avatar,
    :styles => { :square => "50x50#", :small => "50x50#", :normal => "100x100#", :large => "200x200#" }, 
	  :storage => :s3,
	  :s3_credentials => "#{Rails.root}/config/s3.yml",
	  :path => ":attachment/:id/:style.:extension",
	  :bucket => "ultrakast-dev"
  
  def self.search(search, type)
    if search
      if type == "Email"
        where("UPPER(#{type}) LIKE UPPER(?)", "%#{search}%")
      else
        where("UPPER(first_name || ' ' || last_name) LIKE UPPER(?)", "%#{search}%")
      end
    else
      all
    end
  end
  
  def feed(status, categories, sort)
    if status == "public"
	    posts = Post.shared(id)
	  elsif status == "private"
	    ((users = []) << id << friend_ids).flatten!
	    posts = Post.by_users(users)
	  elsif status == "favorites"
	    posts = Post.favorites(id)
    elsif status == "user"
      posts = Post.by_users(self)
    elsif status == "tagged"
      posts = Post.with_tagged_user(self.name)
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
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    
    unless user
      puts "First time user #{auth.info.email}"
      p auth
      email = auth.info.email
      
      if !email or email.empty?
        puts "Email returning empty -- facebook bug for 5% of users without a valid primary email..."
        email = "#{auth.extra.raw_info.username}@facebook.com"
      end
      p email
      user = User.create(first_name: auth.extra.raw_info.first_name,
                         last_name: auth.extra.raw_info.last_name, 
                         provider: auth.provider,
                         uid: auth.uid,
                         email: email,
                         password: Devise.friendly_token[0,20])
    end
    user
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
end