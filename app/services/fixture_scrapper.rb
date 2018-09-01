# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class FixtureScrapper
  def self.fixtures(url)
    new(url).fixtures
  end

  private_class_method :new
  def initialize(url)
    @url = url
    @data = scrap_website
  end

  def fixtures
    @data
      .yield_self(&method(:extract_fixtures))
      .yield_self(&method(:remove_white_space))
      .yield_self(&method(:reject_blank))
      .yield_self(&method(:remove_penalties_and_extra_time))
      .yield_self(&method(:split_fixtures))
  end

  private

  def scrap_website
    Nokogiri::HTML(open(@url), &:noblanks)
  end

  def extract_fixtures(fixtures)
    fixtures.css('table.Table').css('td').each_with_object([]) do |element, fixture_list|
      fixture_list << element.text
    end
  end

  def remove_white_space(fixtures)
    fixtures.map { |elem| elem.gsub(/\s\s+/, '') }
  end

  def reject_blank(fixtures)
    fixtures.reject(&:blank?)
  end

  def remove_penalties_and_extra_time(fixtures)
    fixtures.reject { |elem| elem.match(/Pen\s?+\d-\d|HT\s?+\d-\d|AET/) }
  end

  def split_fixtures(fixtures)
    fixtures[1..-1]&.split { |elem| elem.match(fixtures[0]) }
  end
end
