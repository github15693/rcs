module GlyphHelper
  # ==== Examples
  # glyph(:share_alt)
  # # => <span class="glyphicon glyphicon-share-alt"></span>
  # glyph(:thumbs_up, :pull_left)
  # # => <i class="glyphicon glyphicon-thumbs-up pull-left"></i>
  def glyph(*names)
    names.map! { |name| name.to_s.gsub('_','-') }
    names.map! do |name|
      name =~ /pull-(?:left|right)/ ? name : "glyphicon glyphicon-#{name}"
    end
    content_tag :span, nil, :class => names
  end
end

