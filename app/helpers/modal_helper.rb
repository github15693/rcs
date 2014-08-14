module ModalHelper
  def default_options
    {id: 'modal', size: 'modal-md',}
  end

  def modal_content(options = {}, &block)
    options = default_options.merge(options)
    content_tag :div, :id => options[:id], class: 'modal fade' do
      content_tag :div, class: "modal-dialog #{options[:size]}" do
        content_tag :div, class: 'modal-content', &block
      end
    end
  end

  def modal_header(content_or_has_close = nil, has_close = true, &block)
    has_close = content_or_has_close if block_given?
    content_tag :div, class: 'modal-header' do
      concat close_button if has_close
      concat content_tag(:h4, content_or_has_close, class: 'modal-title', &block)
    end
  end

  def modal_body(content_or_options = nil, &block)
    content_tag :div, content_or_options, class: 'modal-body', &block
  end

  def modal_footer(content_or_options = nil, &block)
    content_tag :div, content_or_options, class: 'modal-footer', &block
  end

  def close_button
    content_tag :button, { class: 'close', data: { dismiss: 'modal' } } do
      concat content_tag :span, '&times;'.html_safe, { 'aria-hidden' => true }
      concat content_tag :span, 'Close', { class: 'sr-only' }
    end
  end

  def modal_toggle(content, options)
    default_options = { class: 'btn btn-default', type: :button, data: { toggle: :modal, target: options[:target] } }.merge(options)
    content_tag :button, content, default_options, true
  end
end

