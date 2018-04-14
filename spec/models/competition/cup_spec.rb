# frozen_string_literal: true

RSpec.describe Competition::Cup do
  let(:cup) { create :cup }

  describe '#scheduled_fixtures' do
    subject { cup.scheduled_fixtures }

    let!(:fixture) { create :fixture, date: Time.now.utc + 1.week, competition: cup }

    it { is_expected.to eq [fixture] }
  end

  describe '#results' do
    subject { cup.results }

    let!(:result) { create :fixture, date: Time.now.utc - 1.week, competition: cup }

    it { is_expected.to eq [result] }
  end
end
