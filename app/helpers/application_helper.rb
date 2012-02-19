module ApplicationHelper
  
  def title
    base_title = "pal.atab.le"
    
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
