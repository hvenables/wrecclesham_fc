# frozen_string_literal: true

class TeamCompetition < ApplicationRecord
  belongs_to :team
  belongs_to :competition
end
