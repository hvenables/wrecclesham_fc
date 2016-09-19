require 'open-uri'
require 'nokogiri'

class Fixture < ApplicationRecord
  belongs_to :league_table
  belongs_to :home, class_name: 'Team', foreign_key: "home_id"
  belongs_to :away, class_name: 'Team', foreign_key: "away_id"
end
