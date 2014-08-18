module RootsHelper

  def menu_item(name = nil, path = nil, options = {})
    content_tag(:li, link_to(name, path), options)
  end

  def alert_bs(content, type = 'success', dismissible = true)
    content_tag :div, { class: "alert alert-#{type}#{' alert-dismissible' if dismissible}", role: 'alert' } do
      if dismissible
        concat(
          capture do
            content_tag :button, { class: 'close', data: { dismiss: 'alert' } } do
              concat content_tag :span, '&times;'.html_safe, { 'aria-hidden' => true }
              concat content_tag :span, 'Close', { class: 'sr-only' }
            end
          end
        )
      end
      concat content
    end
  end

  def contextual content_or_options = nil, options = {}, &block
    options = { class: 'text-danger' }.merge options
    content_tag :p, content_or_options, options, &block
  end

end

