class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each do |post|
    sp_list
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

  private

  def post_params
    params.require(:post).permit(:title, :url, :image).merge(user_id: current_user.id)
  end
  def sp_list
    url = "https://open.spotify.com/playlist/3OPacWA7p63EXLCDYMO2rO"
    url.slice!("https://open.spotify.com/playlist/")
    require 'rspotify'
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    playlist = RSpotify::Playlist.find_by_id(url)
    @musics = playlist.tracks(limit:10)
    @musics_num = @musics.length
  end
end
