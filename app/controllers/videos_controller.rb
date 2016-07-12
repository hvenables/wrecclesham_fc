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

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      flash[:notice] = 'Video has been successfully updated'
      redirect_to video_path(@video)
    else
      flash[:error] = 'Video could not be updated'
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      flash[:notice] = 'Video has been deleted'
      redirect_to videos_path
    else
      flash[:error] = "Video could not be deleted"
      redirect_to video_path(@video)
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :summary, :url)
  end
end
