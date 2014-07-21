namespace :db do
  
  desc "Erase and fill database"
  #task :reseed => [:environment, 'db:reset', 'db:migrate', 'db:users', 'db:add_friendships', 'db:categories', 'db:add_categories', 'db:posts']
  task :reseed => [:environment, 'db:reset', 'db:migrate', 'db:users', 'db:categories']
  
  desc "Create users"
  task :users => :environment do
    u = User.new(first_name: "John", last_name: "Duffy", email: "1@1.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Penguins.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 777835, avatar_updated_at: "2012-08-07 15:28:49")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Jackie", last_name: "Smith", email: "2@2.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Koala.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 780831, avatar_updated_at: "2012-08-07 15:18:38")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Margaret", last_name: "Wilson", email: "3@3.com", password: "111111", password_confirmation: "111111", avatar_file_name: "Tulips.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 620888, avatar_updated_at: "2012-08-07 15:24:38")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Sam", last_name: "Marcos", email: "4@4.com", password: "111111", password_confirmation: "111111")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Mike", last_name: "O'Neill", email: "5@5.com", password: "111111", password_confirmation: "111111")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Jill", last_name: "Compo", email: "6@6.com", password: "111111", password_confirmation: "111111")
    #u.skip_confirmation!
    u.save
    u = User.new(first_name: "Paul", last_name: "Speaker", email: "7@7.com", password: "111111", password_confirmation: "111111")
    #u.skip_confirmation!
    u.save
  end
  
  desc "Create categories"
  task :categories => :environment do
    cat = Category.create name: "Greek Life"
    cat.children.create name: "SIG"
    cat.children.create name: "ZBT"
    cat.children.create name: "AEPI"
    cat.children.create name: "THETA"
    cat.children.create name: "SDT"

    cat = Category.create name: "Organiztions"
    cat.children.create name: "Marketing Club"
    cat.children.create name: "Computer Science Club"
    cat.children.create name: "Finance Club"
    cat.children.create name: "Karate Club"
    cat.children.create name: "Chess Club"

    
    cat = Category.create name: "Dorms"
    cat.children.create name: "Markley"
    cat.children.create name: "Cousins"
    cat.children.create name: "Bursley"
    cat.children.create name: "East Quad"
    cat.children.create name: "West Quad"


    cat = Category.create name: "Interests"
    cat.children.create name: "News"
    cat.children.create name: "Sports"
    cat.children.create name: "Entertainment"
    cat.children.create name: "Gaming"
    cat.children.create name: "Technology"
    cat.children.create name: "Travel"
    cat.children.create name: "Other"
    
  
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
    friendship = user1.friendships.build(:friend_id => user2.id)
	  friendship.save
	  inverse = user2.friendships.build(:friend_id => user1.id)
	  inverse.save
	  friendship = user1.friendships.build(:friend_id => user3.id)
	  friendship.save
	  inverse = user3.friendships.build(:friend_id => user1.id)
	  inverse.save
	  friendship = user1.friendships.build(:friend_id => user4.id)
	  friendship.save
	  inverse = user4.friendships.build(:friend_id => user1.id)
	  inverse.save
  end
  
  desc "Create posts"
  task :posts => :environment do
	  (2..10).each do |k|
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
    
    