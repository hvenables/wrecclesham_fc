# frozen_string_literal: true

class ResultUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Team.wrecclesham.each(&:update_fixtures)
  end
end
