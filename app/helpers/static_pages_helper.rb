module StaticPagesHelper

  def filter_title(base_title)
    unless base_title.nil?
      if base_title == ""
        session[:filter_title] = ""
      else
        session[:filter_title] = "(filtered by " + base_title + ")"
      end
    end
    session[:filter_title]
  end
end
