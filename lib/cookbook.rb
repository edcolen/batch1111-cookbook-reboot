require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load
  end

  def all
    @recipes
  end

  def create(recipe)
    @recipes << recipe
    save
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save
  end

  def load
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def save
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
