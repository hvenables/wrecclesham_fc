# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class FixtureScrapper
  attr_reader :url, :data

  def initialize(url)
    @url = url
    @data = scrap_website
  end

  def fixtures
    fixture_list = extract_fixtures
    fixture_list = fixture_list.each { |elem| elem.gsub!(/\s\s+/, '') }.reject(&:blank?)
    fixture_list = fixture_list.reject { |elem| elem.match(/Pen\s?+\d-\d|HT\s?+\d-\d|AET/) }

    split_fixtures(fixture_list)
  end

  private

  def scrap_website
    Nokogiri::HTML(open(url), &:noblanks)
  end

  def extract_fixtures
    data.css('table.Table').css('td').each_with_object([]) do |element, fixture_list|
      fixture_list << element.text
    end
  end

  def split_fixtures(fixtures)
    fixtures[1..-1].split { |elem| elem.match(fixtures[0]) }
  end
end
