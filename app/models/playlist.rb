class Playlist < ApplicationRecord
  belongs_to :post
  belongs_to :music
end
