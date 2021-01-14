class PostsController < ApplicationController

  def index
    @posts = Post.all
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

  def sp_list(url)
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

  helper_method :sp_list

  private

  def post_params
    params.require(:post).permit(:title, :url, :image).merge(user_id: current_user.id)
  end

end
