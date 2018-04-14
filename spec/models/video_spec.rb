# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:url) }

  context 'when valid url' do
    subject { described_class.new(url: 'https://www.youtube.com/embed/2iOQ053s_oM').url_santizer }

    it { is_expected.to eq '//www.youtube.com/embed/2iOQ053s_oM' }
  end

  context 'when invalid url' do
    subject { described_class.new(url: 'https://www.youtube.com/2iOQ053s_oM') }

    it { is_expected.not_to be_valid }
  end
end
