class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "You have successfully published a new video"
      redirect_to video_path(@video)
    else
      flash[:error] = "Their has been an error in creating a video"
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:title, :summary, :url)
  end
end
