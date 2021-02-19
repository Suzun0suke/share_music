class PostMusic
  include ActiveModel::Model
  attr_accessor :title, :url, :image, :user_id, :track, :tag_list

  with_options presence: true do
    validates :title
    validates :image
    validates :url, format: {with: /https?:\/\/open.spotify.com\/playlist\/[a-zA-Z0-9]{22}\?si=[a-zA-Z0-9]{16}/}
  end

  def sp_list(url)
    if url.match("https://open.spotify.com/playlist/")
      @musics =[]
      music_1 = []
      id = url.slice(34..55)
      require 'rspotify'
      RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
      playlist = RSpotify::Playlist.find_by_id(id)
      music_list = playlist.tracks
      music_list.length.times do |i|
        music_1 << music_list[i]
      end
      music_1.length.times do |i|
        @musics << music_1[i].name
      end
      return @musics
    end
  end

  def save
    post = Post.create(title: title, url: url, user_id: user_id, image: image, tag_list: tag_list )
    sp_list(url)
    @musics.uniq.each do |track|
      music = Music.where(track: track).first_or_initialize
      if music.save
      Playlist.create(post_id: post.id, music_id: music.id)
      end
    end
  end
end