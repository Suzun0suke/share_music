class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :post_set, only:[:show, :edit, :update]
  before_action :move_to_index, only:[:edit]
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def sp_list(url)
    if url.match("https://open.spotify.com/playlist/")
      musics =[]
      url.slice!("https://open.spotify.com/playlist/")
      require 'rspotify'
      RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
      playlist = RSpotify::Playlist.find_by_id(url)
      music_list = playlist.tracks(limit:10)
      music_list.length.times do |i|
        musics << music_list[i]
      end
      return musics
    end
  end

  def sp_list_full(url)
    if url.match("https://open.spotify.com/playlist/")
      musics =[]
      url.slice!("https://open.spotify.com/playlist/")
      require 'rspotify'
      RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
      playlist = RSpotify::Playlist.find_by_id(url)
      music_list = playlist.tracks
      music_list.length.times do |i|
        musics << music_list[i]
        end
        return musics
      end
    end

  helper_method :sp_list, :sp_list_full

  private

  def post_params
    params.require(:post).permit(:title, :url, :image, :name, :tag_list).merge(user_id: current_user.id)
  end

  def post_set
    @post = Post.find(params[:id])
  end

  def move_to_index
    if current_user.id != @post.user_id
      redirect_to root_path
    end
  end
end
