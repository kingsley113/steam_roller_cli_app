require 'open-uri'
require 'pry'

class Scraper
# establish attributes

# scrape Steam new release games page
def scrape_new_release_page(html_link)
  doc = Nokogiri::HTML(open(html_link))
  game_list = doc.css(".tab_item.app_impression_tracked")
  binding.pry

# scrape Steam highest rated games page

# Scrape game page to fill in missing game info - only after selected on users
# 2nd input selection to save time

# Scrape Developer page and get list of games they released
end
