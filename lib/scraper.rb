require 'open-uri'
require 'pry'

class Scraper
# establish attributes
@@new_release_link = "https://store.steampowered.com/games/#p=0&tab=NewReleases"
@@top_sellers_link = "https://store.steampowered.com/games/#p=0&tab=TopSellers"

# scrape Steam new release games page
  def scrape_new_release_page
    # get html data from website
    doc = Nokogiri::HTML(open(@@new_release_link))
    # create array of list of game elements on page
    all_games = doc.css(".tab_content_ctn.sub, NewReleaseRows")
    #complete attribute info on each game
    game = all_games.each_with_index do |index, content|


    # game_name = first_game.css(".tab_item_name").text
    binding.pry
  end
# scrape Steam highest rated games page

# Scrape game page to fill in missing game info - only after selected on users
# 2nd input selection to save time

# Scrape Developer page and get list of games they released
end
