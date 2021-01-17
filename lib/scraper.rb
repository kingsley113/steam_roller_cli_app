require 'open-uri'
require 'pry'

class Scraper
# establish attributes

# scrape Steam new release games page
def self.scrape_new_release_page(index_url)
  doc = Nokogiri::HTML(open("https://store.steampowered.com/explore/new/"))
  game_list = doc.css(".tab_item.app_impression_tracked")

# scrape Steam highest rated games page

# Scrape game page to fill in missing game info - only after selected on users
# 2nd input selection to save time

# Scrape Developer page and get list of games they released
end
