# frozen_string_literal: true

module ApplicationHelper
  def format_year(year)
    base = year.to_s.split(//).last(2).join
    next_year = (base.to_i + 1).to_s
    year.to_s + '/' + next_year
  end

  def active_class(location)
    controller_name == location ? 'active' : ''
  end

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-warning',
      alert: 'alert-warning',
      notice: 'alert-success'
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
