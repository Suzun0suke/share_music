module ApplicationHelper
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
      music_list = playlist.tracks(limit:40)
      music_list.length.times do |i|
        musics << music_list[i]
        end
        return musics
      end
    end
end
