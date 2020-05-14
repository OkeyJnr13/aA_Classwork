# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create_table "artworks", force: :cascade do |t|
#     t.string "title", null: false
#     t.text "image_url", null: false
#     t.integer "artist_id", null: false
#     t.index ["artist_id", "title"], name: "index_artworks_on_artist_id_and_title", unique: true
#     t.index ["artist_id"], name: "index_artworks_on_artist_id"
#   end  create_table "artwork_shares", force: :cascade do |t|

#  create_table "artworks", force: :cascade do |t|
#     t.string "title", null: false
#     t.text "image_url", null: false
#     t.integer "artist_id", null: false
#     t.index ["artist_id", "title"], name: "index_artworks_on_artist_id_and_title", unique: true
#     t.index ["artist_id"], name: "index_artworks_on_artist_id"
#   end


#   create_table "artwork_shares", force: :cascade do |t|
#     t.integer "artwork_id", null: false
#     t.integer "viewer_id", null: false
#     t.index ["artwork_id"], name: "index_artwork_shares_on_artwork_id"
#     t.index ["viewer_id"], name: "index_artwork_shares_on_viewer_id"
#   end


ActiveRecord::Base.transaction do
#  User.destroy_all
 Artwork.destroy_all
 ArtworkShare.destroy_all
 
#  u1 = User.create!(username: 'Markov')
#  u2 = User.create!(username: 'Van Gogh')
#  u3 = User.create!(username: 'Ashe')
#  u4 = User.create!(username: 'Okey')
#  u5 = User.create!(username: 'Leonardo Da Vinci')
 
 a1 = Artwork.create!(title: "Mona Lisa", image_url: "monalisa.com", artist_id: 34 )
 a2 = Artwork.create!(title: "SQL is hard", image_url: "sql.com", artist_id: 33 )
 a3 = Artwork.create!(title: "Naked Lunch", image_url:"naked_lunch.aa", artist_id: 30)
 a4 = Artwork.create!(title: "Starry Night", image_url:"starry_night.com", artist_id: 31)
 
 as1 = ArtworkShare.create!(artwork_id: 1, viewer_id: 31)
 as2 = ArtworkShare.create!(artwork_id: 2, viewer_id: 32)
 as3 = ArtworkShare.create!(artwork_id: 3, viewer_id: 33)
 as4 = ArtworkShare.create!(artwork_id: 4, viewer_id: 34)
 as5 = ArtworkShare.create!(artwork_id: 1, viewer_id: 30)
 as6 = ArtworkShare.create!(artwork_id: 4, viewer_id: 32)
 

end
