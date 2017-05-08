# frozen_string_literal: true

module VideoHelper
  def stub_yt
    url = OpenStruct.new(thumbnail_url: 'https://i.ytimg.com/vi/2iOQ053s_oM/mqdefault.jpg')
    allow(Yt::Video).to receive(:new).and_return(url)
    allow(url).to receive(:thumbnail_url).and_return(url.thumbnail)
  end
end
