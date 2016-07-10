class NewsController < ApplicationController

  def index
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_params)
      flash[:notice] = "Succesfully updated the news article"
      redirect_to news_path(@news)
    else
      flash[:error] = "Failed to update"
      render :edit
    end
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:notice] = "News story successfully published"
      redirect_to news_path(@news)
    else
      flash[:error] = "News story failed to save"
      render :new
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :summary, :content, :image)
  end
end
