class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = current_user.channels
  end

  def new
    @channel = current_user.channels.new
  end

  def create
    @channel = current_user.channels.new params[:channel]

    if @channel.save
      redirect_to user_channels_path(current_user), notice: 'Channel was successfully created.'
    else
      flash.alert = 'There were some errors'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @channel.update_attributes(params[:channel])
      redirect_to user_channels_path(current_user), notice: 'Channel was successfully updated.'
    else
      flash.alert = 'There were some errors'
      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to user_channels_path(current_user), notice: 'Channel was successfully deleted.'
  end

  private

  def find_channel
    @channel = current_user.channels.where(id: params[:id]).first
  end
end
