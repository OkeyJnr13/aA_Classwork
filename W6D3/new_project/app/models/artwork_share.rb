class ArtworkShare < ApplicationRecord

    validates :artwork_id, :viewer_id, presence: true

    belongs_to :viewer,
    foreign_key: :viewer_id,
    class_name: :User

    belongs_to :artwork,
    foreign_key: :artwork_id,
    class_name: :Artwork

end

#   create_table "artwork_shares", force: :cascade do |t|
#     t.integer "artwork_id", null: false
#     t.integer "viewer_id", null: false
#     t.index ["artwork_id"], name: "index_artwork_shares_on_artwork_id"
#     t.index ["viewer_id"], name: "index_artwork_shares_on_viewer_id"
#   end