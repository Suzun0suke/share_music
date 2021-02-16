module ApplicationHelper
  

  def sp_list_full(url)
    if url.match("https://open.spotify.com/playlist/")
      musics =[]
      id = url.slice(34..55)
      require 'rspotify'
      RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
      playlist = RSpotify::Playlist.find_by_id(id)
      music_list = playlist.tracks(limit:40)
      music_list.length.times do |i|
        musics << music_list[i]
        end
        return musics
      end
    end
end
