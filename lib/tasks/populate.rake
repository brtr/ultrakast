namespace :db do
  
  desc "Erase and fill database"
  #task :reseed => [:environment, 'db:reset', 'db:migrate', 'db:users', 'db:add_friendships', 'db:categories']
  task :reseed => [:environment, 'db:reset', 'db:migrate', 'db:users', 'db:categories', 'db:add_categories', 'db:posts']
  
  desc "Create users"
  task :users => :environment do
    User.create name: "John Duffy", email: "1@1.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Penguins.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 777835, avatar_updated_at: "2012-08-07 15:28:49"
    User.create name: "Jackie Smith", email: "2@2.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Koala.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 780831, avatar_updated_at: "2012-08-07 15:18:38"
    User.create name: "Margaret Wilson", email: "3@3.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Tulips.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 620888, avatar_updated_at: "2012-08-07 15:24:38"
    User.create name: "Sam Marcos", email: "4@4.com", password: "111111", password_confirmation: "111111"
    User.create name: "Mike O'Neill", email: "5@5.com", password: "111111", password_confirmation: "111111"
    User.create name: "Jill Compo", email: "6@6.com", password: "111111", password_confirmation: "111111"
    User.create name: "Paul Speaker", email: "7@7.com", password: "111111", password_confirmation: "111111"
  end
  
  desc "Create categories"
  task :categories => :environment do
    cat = Category.create name: "Sports"
    cat.children.create name: "Other"    
    cat.children.create name: "Football"
    cat.children.create name: "Basketball"
    cat.children.create name: "Baseball"
    cat.children.create name: "Hockey"
    cat.children.create name: "Soccer"
    cat.children.create name: "Tennis"
    cat.children.create name: "Golf"
    cat.children.create name: "Lacrosse"
    cat.children.create name: "MMA"
    cat.children.create name: "Boxing"
    cat.children.create name: "Extreme Sports"
    
    cat = Category.create name: "Fashion"
    cat.children.create name: "Other"
    cat.children.create name: "Women's Apparel"
    cat.children.create name: "Shoes"
    cat.children.create name: "Handbags"
    cat.children.create name: "Jewelry/Accessories"
    cat.children.create name: "Trends"
    cat.children.create name: "Men's"
    
    cat = Category.create name: "News"
    cat.children.create name: "Other"
    cat.children.create name: "Business"
    cat.children.create name: "World"
    cat.children.create name: "US"
    cat.children.create name: "Politics"
    cat.children.create name: "Technology"
    cat.children.create name: "Science"
    cat.children.create name: "Health"

    cat = Category.create name: "Music"
    cat.children.create name: "Other"
    cat.children.create name: "Hip Hop/Rap"
    cat.children.create name: "Pop"
    cat.children.create name: "Rock"
    cat.children.create name: "EDM"
    cat.children.create name: "Country"
    cat.children.create name: "R&B/Soul"
    cat.children.create name: "Alternative"
    cat.children.create name: "Reggae"
    cat.children.create name: "Jazz/Blues"
    cat.children.create name: "Soundtrack"
    
    cat = Category.create name: "Literature"
    cat.children.create name: "Other"
    cat.children.create name: "Fiction"
    cat.children.create name: "Non-fiction"
    cat.children.create name: "Short Stories"
    cat.children.create name: "Self-help"
    cat.children.create name: "Best-seller"
    cat.children.create name: "Biography"

    cat = Category.create name: "Movies"
    cat.children.create name: "Other"
    cat.children.create name: "Comedy"
    cat.children.create name: "Drama"
    cat.children.create name: "Action"
    cat.children.create name: "Sci-fi"
    cat.children.create name: "Family"
    cat.children.create name: "Thriller/Horror"
    cat.children.create name: "Romance"
    cat.children.create name: "Upcoming"
    cat.children.create name: "Documentary"
    
    cat = Category.create name: "TV"
    cat.children.create name: "Other"
    cat.children.create name: "Comedy"
    cat.children.create name: "Drama"
    cat.children.create name: "Action"
    cat.children.create name: "Reality"
    cat.children.create name: "Sci-fi"
    cat.children.create name: "Family"
    cat.children.create name: "Documentary"
    
    cat = Category.create name: "Art"
    cat.children.create name: "Other"
    cat.children.create name: "Paintings"
    cat.children.create name: "Photo"
    cat.children.create name: "Street Art"
    cat.children.create name: "Modern Art"
    cat.children.create name: "Contemporary"
    cat.children.create name: "Photoshop"
    
    cat = Category.create name: "Miscellaneous"
    cat.children.create name: "Other"
    cat.children.create name: "Humor"
    cat.children.create name: "Food"
    cat.children.create name: "Autos"
    cat.children.create name: "Travel"
    cat.children.create name: "Fitness"
    cat.children.create name: "Nightlife"
    cat.children.create name: "Gambling/Cards"
    cat.children.create name: "Animals/Pets"
    cat.children.create name: "Gaming"
    cat.children.create name: "Celebrity Gossip"    
  end
  
  desc "Add categories to users"
  task :add_categories => :environment do
	(1..13).each do |k|
	  category = Category.find(k)
	  [1,3].each do |i|
	    User.find(i).categories << category
	  end
	end
	
	(14..21).each do |k|
	  category = Category.find(k)
	  (2..4).each do |i|
	    User.find(i).categories << category
	  end
	end
  end
  
  desc "Create friendships"
  task :add_friendships => :environment do
    user1 = User.find(1)
	user2 = User.find(2)
	user3 = User.find(3)
	user4 = User.find(4)
    @friendship = user1.friendships.build(:friend_id => user2.id)
	  @friendship.save
	  @inverse = user2.friendships.build(:friend_id => user1.id)
	  @inverse.save
	  @friendship = user1.friendships.build(:friend_id => user3.id)
	  @friendship.save
	  @inverse = user3.friendships.build(:friend_id => user1.id)
	  @inverse.save
	  @friendship = user1.friendships.build(:friend_id => user4.id)
	  @friendship.save
	  @inverse = user4.friendships.build(:friend_id => user1.id)
	  @inverse.save
  end
  
  desc "Create posts"
  task :posts => :environment do
	  (1..21).each do |k|
	    cat = Category.find(k)
	    (1..4).each do |i|
	      user = User.find(i)
    		@post = user.posts.build(content: "I am posting a private post about #{cat.name}", category_id: k, shared: false)
		    @post.save
		    @post = user.posts.build(content: "I am posting a public post about #{cat.name}", category_id: k, shared: true)
		    @post.save
	    end
	  end
  end
end
    
    