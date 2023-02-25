class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, i|
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{done} - #{i + 1} - #{recipe.name} - #{recipe.description} (#{recipe.rating}) (#{recipe.prep_time})"
    end
  end

  def ask_user_for(info)
    puts "What's the recipe's #{info}?"
    print '> '
    gets.chomp
  end
end
