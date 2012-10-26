# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @db_movie=Movie.create(movie)
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    step %Q{I #{uncheck}check "ratings_#{rating.strip}"}
  end
end

Then /I should (not )?see the movies (.*)/ do |not_, movie_list|
  movie_list.split(',').each do |movie|
    step %Q{I should #{not_}see #{movie.strip}}
  end
end

Then /I should (not )?see (all the |any )?movie(s)?/ do |not_,how_many,s|
  if how_many == "all the " then should_be = 10; end
  if how_many == "any " then should_be = 0; end
  assert(page.find_by_id("movies").find("tbody").all("tr").count == should_be,"NO HAY #{should_be} PELICULAS!!")
end

