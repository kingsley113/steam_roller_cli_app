require 'pry'

class Game
# establish attributes
  attr_accessor :name, :price, :release_date, :developer, :tags, :rating, :link, :list_no

  @@all = []

# initialize
  def initialize(name, price = nil, link) #initialize with only name and price data from first scrape
    @name = name
    @price = price
    @link = link
  end

# save
  def save
    @@all << self
  end

# all - class method
  def self.all
    @@all
  end

# reset all game objects
  def self.reset_all
    @@all.clear
  end

# create game objects
  def self.create_from_collection(game_list)
    game_list.each do |game_object|
      game = Game.new(game_object[:name], game_object[:price], game_object[:link])
      game.save
    end
  end


# check for missing info - pass to scraper to get info
  def add_missing_info
  # scrape game page and gather the detailed info
  game_detail = Scraper.new.scrape_game_page(link)

  # add detailed game info to the instance attributes
  @release_date = game_detail[:release_date]
  @developer = game_detail[:developer]
  @rating = game_detail[:rating]
  @tags = game_detail[:tags]
  end

end
