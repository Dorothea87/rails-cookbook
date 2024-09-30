class Bookmark < ApplicationRecord
  belongs_to :recipe
  belongs_to :category
  validates :comment, length: {  minimum: 6 }
  validates :recipe_id, uniqueness: { scope: :category_id, message: "This recipe and category pairing must be unique."}
end
