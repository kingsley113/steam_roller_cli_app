require 'open-uri'
require 'pry'

class Scraper
# establish attributes
@@new_release_link = "https://store.steampowered.com/games/#p=0&tab=NewReleases"
@@top_sellers_link = "https://store.steampowered.com/games/#p=0&tab=TopSellers"
@@all = []
# scrape Steam new release games page
  def scrape_new_release_page
    # get html data from website
    doc = Nokogiri::HTML(open(@@new_release_link))
    # create array of list of game elements on page
    all_games = doc.css('div#NewReleasesRows a')

    #scrape basic info on each game available from the list page
    all_games.each do |info|
      game_link   = info["href"]
      game_name   = info.css(".tab_item_name").text
      game_price  = info.css(".discount_final_price").text

      game_info = {:link = game_link, :name = game_name, :price = game_price}
      @@all << game_info
      # binding.pry
    end
    binding.pry
  end
# scrape Steam highest rated games page

# Scrape game page to fill in missing game info - only after selected on users
# 2nd input selection to save time

# Scrape Developer page and get list of games they released
end
