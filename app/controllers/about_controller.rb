# frozen_string_literal: true

class AboutController < ApplicationController
  load_and_authorize_resource

  def index
    @about = About.last
  end

  def edit; end

  def update
    if @about.update(about_params)
      flash[:notice] = 'News story successfully published'
      redirect_to about_index_path
    else
      flash[:error] = "News story failed to save, #{@news.errors.full_messages.join(', ')}"
      render :new
    end
  end

  private

  def about_params
    params.require(:about).permit(:title, :content)
  end
end
