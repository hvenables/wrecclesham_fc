module ApplicationHelper

  def relative_time(creation_time)
    diff = TimeDifference.between(creation_time, Time.now).in_general
    if diff[:weeks] > 0 || diff[:months] > 0 || diff[:years] > 0
      return "Over a week ago"
    elsif diff[:days] == 1
      return "1 day ago"
    elsif diff[:days] > 0
      return "#{diff[:days]} days ago"
    elsif diff[:hours] == 1
      return "1 hour ago"
    elsif diff[:hours] > 0
      return "#{diff[:hours]} hours ago"
    elsif diff[:minutes] == 1
      return "1 minute ago"
    elsif diff[:minutes] > 0
      return "#{diff[:minutes]} minutes ago"
    elsif diff[:seconds] == 1
      return "1 second ago"
    elsif diff[:seconds] > 0
      return "#{diff[:seconds]} seconds ago"
    else
      return "Just now"
    end
  end

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
