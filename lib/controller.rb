require_relative 'view'
require_relative 'recipe'

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
    recipe = Recipe.new(name, description)
    @cookbook.create(recipe)
    list
  end

  def remove
    list
    recipe_index = @view.ask_user_for('number').to_i - 1
    @cookbook.destroy(recipe_index)
    list
  end
end
