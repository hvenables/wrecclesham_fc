# frozen_string_literal: true

RSpec.describe Cup do
  let(:cup) { create :cup }

  describe '#scheduled_fixtures' do
    let!(:fixture) { create :fixture, date: Time.now.utc + 1.week, competition: cup }
    subject { cup.scheduled_fixtures }

    it { is_expected.to eq [fixture] }
  end

  describe '#results' do
    let!(:result) { create :fixture, date: Time.now.utc - 1.week, competition: cup }
    subject { cup.results }

    it { is_expected.to eq [result] }
  end
end
