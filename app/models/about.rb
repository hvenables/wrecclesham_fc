# frozen_string_literal: true

class About < ApplicationRecord
  validates :content, presence: true
end
