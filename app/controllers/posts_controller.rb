class PostsController < ApplicationController

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

  # def tag_search
  #   return nil if params[:keyword] == ""
  #   tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
  #   render json:{ keyword: tag}
  # end

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

  helper_method :sp_list

  private

  def post_params
    params.require(:post).permit(:title, :url, :image, :name, :tag_list).merge(user_id: current_user.id)
  end

end
