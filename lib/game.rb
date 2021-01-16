require 'pry'

class Game
# establish attributes
  attr_accessor :name, :price, :release_date, :developer, :rating, :page_link

  @@all = []

# initialize
  def initialize(name, price = nil) #initializing with only name and price data from first scrape
    @name = name
    @price = price
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

# check for missing info - pass to scraper to get info
  def add_missing_info
  # check for empty attributes
  # call scraper class to get info from specific game page
  end

# return info on one specific game instance
end
