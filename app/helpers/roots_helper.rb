module RootsHelper

  def menu_item(name = nil, path = nil, options = {})
    content_tag(:li, link_to(name, path), options)
  end

  def alert_dismissible(content, type = 'success')
    content_tag :div, { class: "alert alert-#{type} alert-dismissible", role: 'alert' } do
      concat(
        capture do
          content_tag :button, { class: 'close', data: { dismiss: 'alert' } } do
            concat content_tag :span, '&times;'.html_safe, { 'aria-hidden' => true }
            concat content_tag :span, 'Close', { class: 'sr-only' }
          end
        end
      )
      concat content
    end
  end

end

