class NewsController < ApplicationController

  def index
    @news = News.all
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save!
      flash[:notice] = "News story successfully published"
      redirect_to news_index_path
    else
      flash[:error] = "News story failed to save"
      render :new
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :content)
  end
end
