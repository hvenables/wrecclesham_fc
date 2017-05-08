# frozen_string_literal: true

class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    @videos = Video.all.order(created_at: :desc).page(params[:page]).per(params[:per])
  end

  def new; end

  def create
    if @video.save
      flash[:notice] = 'You have successfully published a new video'
      redirect_to video_path(@video)
    else
      flash[:error] = "Video failed to save, #{@video.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @video.update(video_params)
      flash[:notice] = 'Video has been successfully updated'
      redirect_to video_path(@video)
    else
      flash[:error] = "Video failed to update, #{@video.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    if @video.destroy
      flash[:notice] = 'Video has been deleted'
      redirect_to videos_path
    else
      flash[:error] = 'Video failed to be deleted'
      redirect_to video_path(@video)
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :content, :url)
  end
end
