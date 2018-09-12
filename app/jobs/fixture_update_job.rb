# frozen_string_literal: true

class FixtureUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Team.wrecclesham.each(&:create_fixtures)
  end
end
