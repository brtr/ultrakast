class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      #Setup new post form
      @post = current_user.posts.build
      #Set default filter behavior
      session[:category_filter] = "all"
      session[:feed_status] = "public"
      session[:filter_title] = ""
      session[:selected_category] = "all"
      session[:sort_order] = "recent"
      session[:user] = current_user.id
      @feed_items = User.find(session[:user]).feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: params[:page], per_page: 10)
    end
  end
  
  def about
  end
  

 
  def share_to_facebook
    #TODO: CHANGE API KEYS
    api_key    = "510492979067102"
    api_secret = "3b2d98b05805d79ac1ea8c2a18d76a74"
    
    fb_file = open(URI.encode("https://graph.facebook.com/me/permissions?access_token=" + session['fb_access_token']))
    fb_data = JSON.parse(fb_file.read)
    if fb_data["data"][0]["publish_stream"].present?
      unless params[:message].nil?
        message = params[:message]
        message = ActionView::Base.full_sanitizer.sanitize(message)
      end
      if params[:picture].nil? || params[:picture] == "/images/original/missing.png"
        #TODO: CHANGE URL FOR PRODUCTION
        #picture = "http://polar-ocean-9301.herokuapp.com/assets/large-satellite.png"
        picture = "http://www.ultrakast.com/assets/large-satellite.png"
      else
        picture = params[:picture]
      end
    

      unless params[:post_id].nil?
        #TODO: CHANGE URL FOR PRODUCTION
        #link = "http://polar-ocean-9301.herokuapp.com/posts/" + params[:post_id].to_s
        link = "http://www.ultrakast.com/posts/" + params[:post_id].to_s
      end
    
      client = OAuth2::Client.new(api_key, api_secret, :site => 'https://graph.facebook.com')
      token = OAuth2::AccessToken.new(client, session['fb_access_token'])
      token.post('/me/feed', {body: {:message => message, :picture => picture, :link => link, :name => "Ultrakast"}})
      redirect_to root_path   
    end
  end
  
  def switch_feed
    #Set user
    unless params[:user].nil?
      session[:user] = params[:user]
    end
  
    #Set sort order
    unless params[:sort_order].nil?
      session[:sort_order] = params[:sort_order]
    end
    
    #Set feed status
    unless params[:feed_status].nil?
      session[:feed_status] = params[:feed_status]
    end
    
    #Set selected category
    unless params[:selected_category].nil?
      session[:selected_category] = params[:selected_category]
    end
  
    #Set parent category
    unless params[:parent_category].nil?
      session[:parent_category] = params[:parent_category]
    end
      
    #Set page
    if params[:page].nil?
      session[:page] = 1
    else
      session[:page] = params[:page]
    end
    
    update_dropdown
    
    @filter_title = filter_title(session[:filter_title])
    
    if session[:category_filter] != "all"
      cat = Category.find(session[:selected_category])
      session[:selected_category_name] = cat.name
      status = ReadStatus.where("user_id = ? AND category_id = ?", current_user.id, cat.id).first
    end
    
    @feed_items = User.find(session[:user]).feed(session[:feed_status], session[:category_filter], session[:sort_order]).paginate(page: session[:page], per_page: 10)
    
    
  
    if status.nil?
      unless cat.nil?
        status = ReadStatus.create(:user_id => current_user.id, :category_id => cat.id, :last_read_time => Time.now)
      end
    else
      status.last_read_time = Time.now
      status.save
    end

    @post = current_user.posts.build(params[:post])
    respond_to do |format|
      format.html
      format.js
    end
  end
    
  private
    
    def update_dropdown
      #Set the category dropdown options based on filter settings
      unless params[:category_filter].nil?
        session[:category_filter] = params[:category_filter]
      end
    
      unless params[:filter_title].nil?
        session[:filter_title] = params[:filter_title]
      end
    
      if session[:category_filter] == "all"
        @dropdown_parents = current_user.categories.roots
        @dropdown_children = current_user.category_ids
      else
        category = Category.find(session[:selected_category])
        if category.ancestry.nil? #Filtered on parent category - return all children user is subscribed to
          @dropdown_parents = [category] #Needs to be passed as an array so grouped_collection_select can use map on it
          @dropdown_children = current_user.categories.where("ancestry = ?", category.id.to_s).ids
        else
          if
            current_user.categories.ids.include?(category.id)
            @dropdown_parents = [category.parent]
            @dropdown_children = [category.id]
          else
            @dropdown_parents = []
            @dropdown_children = []
          end
        end
      end
    end
end
