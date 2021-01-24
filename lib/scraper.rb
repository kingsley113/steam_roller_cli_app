require 'open-uri'
require 'pry'

class Scraper
# establish attributes
@@new_release_link = "https://store.steampowered.com/games/#p=0&tab=NewReleases"
@@top_sellers_link = "https://store.steampowered.com/games/#p=0&tab=TopSellers"
@@all = []

# ----scrape Steam new release games page----
  def scrape_new_release_page
    doc = Nokogiri::HTML(open(@@new_release_link))  # get html data from website
    game_list = doc.css('div#NewReleasesRows a')    # create array of games

    new_games = assemble_game_info(game_list)       # gather the basic game info
    new_games
  end

# -----scrape Steam highest rated games page----
  def scrape_top_sellers_page
    doc = Nokogiri::HTML(open(@@top_sellers_link))  # get html data from website
    game_list = doc.css('div#TopSellersRows a')     # create array of games

    top_games = assemble_game_info(game_list)       # gather the basic game info
    top_games
  end


  def assemble_game_info(game_data)
    game_list = []
    game_data.each do |info|                  # interate through each game item
      game_link   = info["href"]
      game_name   = info.css(".tab_item_name").text
      game_price  = info.css(".discount_final_price").text

      game_info = {name: game_name, price: game_price, link: game_link}
      game_list << game_info
    end

    game_list
  end


# Scrape game page to fill in missing game info - only after selected on users
# 2nd input selection to save time
  def scrape_game_page(link)
    doc = Nokogiri::HTML(open(link))  # get html data from website
    game_list = doc.css('div#NewReleasesRows a')    # create array of games

# Scrape Developer page and get list of games they released
end
