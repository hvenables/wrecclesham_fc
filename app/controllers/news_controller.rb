class NewsController < ApplicationController
  load_and_authorize_resource

  def index
    @news = News.all.order(created_at: :desc).page(params[:page]).per(params[:per])
  end

  def show
    @latest_news = News.latest_news(@news)
  end

  def new
  end

  def create
    news_params[:content].gsub!(/\n+/, "")
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
    news_params[:content].gsub!(/\n+/, "")
    if @news.update(news_params)
      flash[:notice] = "Succesfully updated the news article"
      redirect_to news_path(@news)
    else
      flash[:error] = "News story failed to update, #{@news.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    if @news.destroy
      flash[:notice] = 'News article has been deleted'
      redirect_to news_index_path
    else
      flash[:error] = "News article could not be deleted"
      redirect_to news_index_path
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :content, :image)
  end
end
