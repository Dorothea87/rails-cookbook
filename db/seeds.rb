# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

Bookmark.destroy_all
Recipe.destroy_all

carbonara = {name: "Spaghetti Carbonara", description: "deliscious Italian pasta recipe", image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-1001491_11-2e0fa5c.jpg?quality=90&webp=true&resize=440,400", rating: 8.5}
beef_stew = {name: "Beef Stew", description: "hearty winter warmer", image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-890477_11-0101064.jpg?quality=90&webp=true&resize=440,400", rating: 7.4}
pavlova = {name: "Pavlova", description: "light and easy summer recipe", image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-356530_11-d256695.jpg?quality=90&webp=true&resize=440,400", rating: 9}
stollen = {name: "Stollen", description: "firm German Christmas staple which can't be missed", image_url: "https://www.nigella.com/assets/uploads/recipes/public-thumbnail/christmasstollen-656716da5c1aa.jpg", rating: 10}
jollof_rice = {name: "Jollof Rice", description: "Best rice in the whole wide world", image_url: "https://cdn.jwplayer.com/v2/media/BRU94itM/poster.jpg?width=720", rating: 10}

[carbonara, beef_stew, pavlova, stollen, jollof_rice].each do |attributes|
  recipe = Recipe.create!(attributes)
  puts "Created #{recipe.name}"
end

categories = ["Pasta", "Dessert", "Beef", "Chicken"]

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  meal_serialized = URI.parse(url).read
  meal = JSON.parse(meal_serialized)
  p meal
  Recipe.create!(name: meal["meals"][0]["strMeal"], description: meal["meals"][0]["strInstructions"], image_url: meal["meals"][0]["strMealThumb"], rating: 0.0)
end

categories.each do |category|
  url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
  meals_serialized = URI.parse(url).read
  meals = JSON.parse(meals_serialized)

  meals["meals"].each do |meal|

  recipe_builder(meal["idMeal"])

  end
end
