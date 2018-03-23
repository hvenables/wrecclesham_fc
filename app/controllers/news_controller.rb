# frozen_string_literal: true

class NewsController < ApplicationController
  load_and_authorize_resource

  def index
    @news = News.all.order(created_at: :desc).page(params[:page])
  end

  def show
    @latest_news = News.latest_news(@news)
  end

  def new
    @news.images << Image.new
  end

  def create
    if @news.save
      flash[:notice] = 'News story successfully published'
      redirect_to news_path(@news)
    else
      flash[:error] = "News story failed to save, #{@news.errors.full_messages.join(', ')}"
      @news.images << Image.new
      render :new
    end
  end

  def edit; end

  def update
    if @news.update(news_params)
      flash[:notice] = 'Succesfully updated the news article'
      redirect_to news_path(@news)
    else
      flash[:error] = "News story failed to update, #{@news.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    if @news.destroy
      flash[:notice] = 'News article has been deleted'
    else
      flash[:error] = 'News article could not be deleted'
    end
    redirect_to news_index_path
  end

  private

  def news_params
    params.require(:news).permit(:title, :content, images_attributes: [:image])
  end
end
