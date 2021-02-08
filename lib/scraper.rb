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
    # get release date
    release_date = doc.css(".release_date div.date").text
    # get developer
    developer = doc.css("#developers_list a").text
    # get rating (recent ratings)
    rating = doc.css(".game_review_summary[@itemprop = 'description']").text
    # get array of user game tags
    tags = []
    doc.css(".app_tag").each do |tag|
      tags << tag.text.delete("\t, \r, \n, +")
    end
    tags.reject! {|t| t.empty?}

    #return game_detail hash to then be inserted into game object later
    game_detail = {release_date: release_date, developer: developer, rating: rating, tags: tags}

    # fill any blank attribute with a "Not Available" (for mature content, etc.)
    game_detail.each do |key, value|
      if value == "" || value == []
        game_detail[key] = "Not Available"
      end
    end

    game_detail
  end


# Scrape Developer page and get list of games they released
end
