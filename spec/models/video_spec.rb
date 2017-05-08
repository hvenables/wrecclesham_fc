# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:url) }

  context '#url_santizer' do
    it 'will remove http from url' do
      subject.url = 'https://www.youtube.com/embed/2iOQ053s_oM'
      expect(subject.url_santizer).to eq '//www.youtube.com/embed/2iOQ053s_oM'
    end
  end

  context '#embedable_url' do
    it 'will raise error if url is not embedable' do
      subject.url = 'https://www.youtube.com/2iOQ053s_oM'
      expect(subject).not_to be_valid
    end
  end
end
