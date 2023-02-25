require "nokogiri"
require 'open-uri'

url = "https://www.allrecipes.com/search?q=strawberry"
html = URI.open(url)
doc = Nokogiri::HTML.parse(html, nil, "utf-8")

doc.search('.mntl-card-list-items').each do |card|
  link = card.attributes['href'].value

  recipe_html = URI.open(link)
  recipe_doc = Nokogiri::HTML.parse(recipe_html, nil, "utf-8")
  name = recipe_doc.search('h1').text.strip
  description = recipe_doc.search('.article-subheading').text.strip
  rating = recipe_doc.search('.mntl-recipe-review-bar__rating').text.strip
  prep_divs = recipe_doc.search('.mntl-recipe-details__item')
  prep_divs.each do |div|
    next if div.search('.mntl-recipe-details__label:contains("Prep Time:")').empty?

    prep_time = div.search('.mntl-recipe-details__value').text.strip
  end
  puts ''
end
