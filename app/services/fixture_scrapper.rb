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

    # reject any element about penalties, half time scores and indication of extra time
    fixture_list.reject! { |elem| elem.match(/Pen\s?+\d-\d|HT\s?+\d-\d|AET/) }

    split_fixtures(fixture_list)
  end

  private

  def scrap_website
    Nokogiri::HTML(open(url), &:noblanks)
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
      if fixture =~ /^[A-Z][a-zA-Z0-9]{2}[A-Z0-9]*$/ && fixture != 'TBC'
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
