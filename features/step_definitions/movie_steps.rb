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

#table is the id of the table
#field is the text that will be searched in TABLE HEADERS
#That will not work with dates that are not in the current format!! (alphabetically orderable)
Then /I should see table (.*) ordered by: (.*)/ do |table,field|
  #find out the column We are searching for
  cnt = 0
  order_field_number = 0
  page.find_by_id(table).find("thead tr").all("th").each do |node|
    cnt = cnt + 1
    if node.text.downcase =~ /#{field}/ then
      order_field_number = cnt
    end
  end
  #verify ordering in that column values
  page.find_by_id(table).find("tbody").all("tr").each do |node|
    cnt = 0
    former_value = nil
    node.all("td").each do |field|
      cnt = cnt + 1
      if cnt == order_field_number then
        if former_value.nil? then former_value = field.text.downcase; end
        assert(field.text.downcase >= former_value, "ORDERING ERROR!! #{field.text} !> #{former_value}")
        former_value = field.text.downcase
      end
    end
  end
end
