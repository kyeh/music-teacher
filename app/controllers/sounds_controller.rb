class SoundsController < ApplicationController
  include SoundcloudHelper
  before_filter :set_client, :only => [:index, :search]

  def index
  end

  def search
    @results = Sound.search(params[:search])
    render :index
  end

  def connected
    sound_profile = Sound.create_sound_profile(params[:code])
    session[:sc_id] = sound_profile.id
    redirect_to sounds_path
  end

  def play
    @track_url = params[:track_url]
    render :play, :layout => false
  end

  private

  def set_client
    @client = current_client
    @app_client = Sound::APP_CLIENT
    @sc_user = current_client.get('/me')
    @sounds = @sc_user.tracks
    @user_sounds = @client.get("/users/#{@sc_user.id}/tracks")
  end
end
