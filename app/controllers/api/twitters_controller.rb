# frozen_string_literal: true

class Api::TwittersController < ApplicationController
  def show
    render json: TwitterFeed.own_tweets
  end
end
