class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.references :post, foreign_key: true
      t.references :music, foreign_key: true
      t.timestamps
    end
  end
end
