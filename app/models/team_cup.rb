# frozen_string_literal: true

class TeamCup < ApplicationRecord
  belongs_to :team
  belongs_to :cup
end
