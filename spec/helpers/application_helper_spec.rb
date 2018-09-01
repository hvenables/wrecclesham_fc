# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let!(:dummy_class) { (Class.new { include ApplicationHelper }).new }

  context '#format_year' do
    it 'returns the year and the next year seperated by a backslash' do
      expect(dummy_class.format_year(2015)).to eq '2015/16'
    end
  end
end
