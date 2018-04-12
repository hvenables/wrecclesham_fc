# frozen_string_literal: true

class AboutsController < ApplicationController
  before_action :load_about, except: %i[new create]

  authorize_resource

  def show; end

  def new
    @about = About.new
  end

  def create
    @about = About.new
    if @about.update(about_params)
      flash[:notice] = 'About successfully created'
      redirect_to about_path
    else
      flash[:error] = "About failed to save, #{@about.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit; end

  def update
    if @about.update(about_params)
      flash[:notice] = 'About successfully published'
      redirect_to about_path
    else
      flash[:error] = "About failed to save, #{@about.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  private

  def about_params
    params.require(:about).permit(:title, :content)
  end

  def load_about
    @about = About.last
  end
end
