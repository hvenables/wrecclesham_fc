class NewsController < ApplicationController
  load_and_authorize_resource

  def index
    @news = News.all.order(created_at: :desc)
  end

  def show
  end

  def new
  end

  def create
    if @news.save
      flash[:notice] = "News story successfully published"
      redirect_to news_path(@news)
    else
      flash[:error] = "News story failed to save, #{@news.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      flash[:notice] = "Succesfully updated the news article"
      redirect_to news_path(@news)
    else
      flash[:error] = "Failed to update, #{@news.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    if @news.destroy
      flash[:notice] = 'News article has been deleted'
      redirect_to videos_path
    else
      flash[:error] = "News article could not be deleted"
      redirect_to video_path(@video)
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :summary, :content, :image)
  end
end
