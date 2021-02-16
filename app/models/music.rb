class Music < ApplicationRecord
  has_many :playlists, dependent: :destroy
  has_many :posts, through: :playlists, dependent: :destroy
end
