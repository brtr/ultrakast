module StaticPagesHelper

  def filter_title(base_title)
    unless base_title.nil?
      if base_title == ""
        base_title
      else
        "(filtered by " + base_title + ")"
      end
    end
  end
end
