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

    fixture_list.each { |elem| elem.gsub!(/\s\s+/, '') }.reject!(&:blank?)

    # reject any element about penalties and half time scores, these are not yet handled
    fixture_list.reject! { |elem| elem.match(/Pen\s?+\d-\d/) || elem.match(/HT\s?+\d-\d/) }

    split_fixtures(fixture_list)
  end

  private

  def scrap_website
    doc = Nokogiri::HTML(open(url), &:noblanks)

    doc
  end

  def extract_fixtures
    fixture_list = []

    data.css('table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list
  end

  def split_fixtures(fixtures)
    fixture_list = []

    fixtures.each do |fixture|
      if fixture =~ /^[A-Z][a-zA-Z0-9]{2}[A-Z0-9]$/
        fixture_list << @current_fixture if @current_fixture
        @current_fixture = []
        @current_fixture << fixture
      else
        @current_fixture << fixture
      end
    end

    fixture_list << @current_fixture if @current_fixture

    fixture_list
  end
end
