module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Vegan Eats Boston"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def website_logo
    link_to image_tag("veb_logo.png", alt: "Vegan Eats Boston"), 
            root_path, 
            id: "logo"
  end
end
