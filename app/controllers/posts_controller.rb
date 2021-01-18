class PostsController < ApplicationController

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Postnew.new
  end

  def create
    @post = Postnew.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json:{ keyword: tag}
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

  helper_method :sp_list

  private

  def post_params
    params.require(:postnew).permit(:title, :url, :image, :name).merge(user_id: current_user.id)
  end

end
