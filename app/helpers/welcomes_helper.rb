module WelcomesHelper
  def menu_item(name = nil, path = nil, options = {})
    content_tag(:li, link_to(name, path), options)
  end
end

