require 'pry'

class Game
# establish attributes
  attr_accessor :name, :price, :release_date, :developer, :rating, :page_link

  @@all = []

# initialize
  def initialize(name, price = nil, link) #initialize with only name and price data from first scrape
    @name = name
    @price = price
    @link = link
  end

# save
  def save
    @all << self
  end

# all - class method
  def self.all?
    @@all
  end

# reset all game objects
  def reset_all
    @@all.clear
  end

# create game objects
  def create_from_collection(game_list)
    game_list.each do |game_object|
      Game.new(game_object[0], game_object[1], game_object[2])
    end
  end
  
# check for missing info - pass to scraper to get info
  def add_missing_info
  # check for empty attributes
  # call scraper class to get info from specific game page
  end

# return info on one specific game instance
end
