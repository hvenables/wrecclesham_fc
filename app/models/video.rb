class Video < ApplicationRecord
  before_save :add_thumbnail

  validates :title, :content, :url, presence: :true
  validate :embedable_url

  def url_santizer
    self.url.gsub(/^http.?:/im, "") if self.url[0..3] == 'http'
  end

  def add_thumbnail
    video = Yt::Video.new url: self.url
    self.thumbnail = video.thumbnail_url('medium')
  end

  def embedable_url
    return false if url.blank?
    unless url.include?("embed")
      errors[:link] << "is not an embedable link please see example"
    end
  end

end
