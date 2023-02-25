require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_all_recipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_list(recipes)
  end

  def add
    name = @view.ask_user_for('name')
    description = @view.ask_user_for('description')
    rating = @view.ask_user_for('rating')
    prep_time = @view.ask_user_for('prep time')
    recipe = Recipe.new(name:, description:, rating:, prep_time:)
    # recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time))
    @cookbook.create(recipe)
    list
  end

  def remove
    list
    recipe_index = @view.ask_user_for('number').to_i - 1
    @cookbook.destroy(recipe_index)
    list
  end

  def import
    ingredient = @view.ask_user_for('ingredient')
    imported_recipes = ScrapeAllrecipesService.import_recipes(ingredient)
    @view.display_list(imported_recipes)
    recipe_index = @view.ask_user_for('number').to_i - 1
    @cookbook.create(imported_recipes[recipe_index])
    list
  end

  def mark
    list
    recipe_index = @view.ask_user_for('number').to_i - 1
    @cookbook.mark_as_done(recipe_index)
    list
  end
end
