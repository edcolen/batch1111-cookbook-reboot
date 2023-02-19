class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, i|
      puts "#{i + 1} - #{recipe.name} - #{recipe.description}"
    end
  end

  def ask_user_for(info)
    puts "What's the recipe's #{info}?"
    print '> '
    gets.chomp
  end
end
