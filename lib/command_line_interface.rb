require_relative "../lib/developer.rb"
require_relative "../lib/game.rb"
require_relative "../lib/scraper.rb"
require "nokogiri"
require "colorize"
require 'pry'

class CommandLineInterface
# establish attributes

# run
def run
  # for testing
  new_releases = Scraper.new.scrape_new_release_page
  top_sellers = Scraper.new.scrape_top_sellers_page
  binding.pry
end

# welcome user, prompt for which list from steam to access

# get user input for list selection

# pass user selection to scraper to get info
#   make game objects from 'new release' list
#   make game objects from 'highest rated' list


# display selected list back to user

# promp user for additional action

# take user input and call next method

# return sorted list - aplhabetically
# return sorted list - price
# return sorted list - rating
# return sorted list - by developer alphabetically
# return sorted list - release date



end
