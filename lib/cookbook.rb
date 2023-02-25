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

  def mark_as_done(recipe_index)
    @recipes[recipe_index].mark_as_done!
    save
  end

  def load
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == 'true'
      @recipes << Recipe.new(row)
    end
  end

  def save
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[name description rating done prep_time]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
