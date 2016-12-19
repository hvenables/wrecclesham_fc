module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def bootstrap_class_for flash_type
    {
      success: 'alert-success',
      error: 'alert-warning',
      alert: 'alert-warning',
      notice: "alert-success"
    }[flash_type.to_sym] || flash_type.to_s
  end

  def gfm(string)
    @markdown ||= Redcarpet::Markdown.new(
      PygmentsHTML.new(escape_html: true),
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      no_intra_emphasis: true
    )
    @markdown.render(string).html_safe
  end
end
