require 'pry'

class SongsController < ApplicationController
    before_action :set_song, only: [:show, :edit, :update, :destroy]
  
    def index
      @songs = Song.all
    end
  
    def show
    end
  
    def new
      @song = Song.new
      @errors = flash[:errors]
    end
  
    def create
      @song = Song.create(strong_params)
        # binding.pry      
        if @song.valid?
        redirect_to @song
      else
        flash[:errors] = @song.errors.full_messages
        redirect_to new_song_path
      end
    end
  
    def edit
        @errors = flash[:errors]
    end
  
    def update
      @song.update(strong_params)
      if @song.valid?
        redirect_to @song
      else
        flash[:errors] = @song.errors.full_messages
        redirect_to edit_song_path(@song)
      end
    end

    def destroy
        @song.destroy
        redirect_to songs_path
    end
  
    private
  
    def set_song
      @song = Song.find(params[:id])
    end
    
    def strong_params
      params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end
  
  end
  