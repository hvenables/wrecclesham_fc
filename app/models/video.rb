class Video < ApplicationRecord

  before_save :add_thumbnail

  def url_santizer
    self.url.gsub(/^http.?:/im, "") if self.url[0..3] == 'http'
  end

  def add_thumbnail
    video = Yt::Video.new url: self.url
    self.thumbnail = video.thumbnail_url('medium')
  end

end
