class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def prepare(collection, options, template)
    @base_link_url = options.delete :base_link_url
    @base_link_url_has_qs = @base_link_url.index('?') != nil if @base_link_url
    super
  end
  
  protected
  
    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'),
      :class => [(classname[0..3] if  @options[:page_links]), (classname if @options[:page_links]), ('disabled' unless page)].join(' ')
    end
  
    def url(page)
      if @base_link_url.blank?
        super
      else
        @base_url_params ||= begin
        merge_optional_params(default_url_params)
      end

      url_params = @base_url_params.dup
      add_current_page_param(url_params, page)

      query_s = []
      url_params.each_pair {|key,val| query_s.push("#{key}=#{val}")}

      if query_s.size > 0
        @base_link_url+(@base_link_url_has_qs ? '&' : '?')+query_s.join('&')
      else
        @base_link_url
      end
    end
  end
end