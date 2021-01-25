require 'pry'

class Game
# establish attributes
  attr_accessor :name, :price, :release_date, :developer, :genre, :link, :list_no

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
  def reset_all
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
  # check for empty attributes
  # call scraper class to get info from specific game page
  end

# return info on one specific game instance
end
