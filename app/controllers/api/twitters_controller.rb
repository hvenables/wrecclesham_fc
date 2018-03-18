# frozen_string_literal: true

class Api::TwittersController < ApplicationController
  def show
    render json: TwitterFeed.new.own_tweets
  end
end
