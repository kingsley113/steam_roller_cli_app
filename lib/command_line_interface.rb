require_relative "../lib/developer.rb"
require_relative "../lib/game.rb"
require_relative "../lib/scraper.rb"
require "nokogiri"
require "colorize"
require 'pry'

class CommandLineInterface
# establish attributes
  attr_accessor :selected_list

# run
  def run
    welcome_user
    user_list_selection = get_first_input
    # for testing
    if user_list_selection == 1
      game_array = Scraper.new.scrape_new_release_page
      make_game_objects(game_array)
      @selected_list = "New Releases:"
    elsif user_list_selection == 2
      game_array = Scraper.new.scrape_top_sellers_page
      make_game_objects(game_array)
      @selected_list = "Top Sellers:"
    end
    display_game_list
    # binding.pry
  end

# welcome user, prompt for which list from steam to access
  def welcome_user
    puts "----------------------------------------------------------------------------"
    puts "Welcome to the Steam Roller! The quickest way to access the top Steam games!"
    puts "----------------------------------------------------------------------------"
    puts "\n"
  end

# get user input for list selection
  def get_first_input
    puts "Which list of games would you like to see?"
    puts "1. New Releases"
    puts "2. Top Selling games"
    puts "(please enter 1 or 2)"
    user_input = gets.chomp.to_i

    if !user_input.between?(1,2)                    # check for valid user input
      puts "Invalid entry, please try again."
      get_first_input
    end

    user_input
  end

# pass user selection to scraper to get info
#   make game objects from 'new release' list
#   make game objects from 'highest rated' list

  def make_game_objects(game_array)
    Game.create_from_collection(game_array)
  end


# display selected list back to user
  def display_game_list
    # identify how many characters in the longest name, for formatting output
    name_length = []
    Game.all.each do |game|
      name_length << game.name.length
    end
    max_length = name_length.max
  # binding.pry

    # output the list header
    puts "\n" + ('-' * (max_length + 20))
    puts "#{@selected_list}".center(max_length + 20, " ")
    puts ('-' * (max_length + 20))

    # output the list details, iterate over each instance
    Game.all.each_with_index do |game, index|
      index < 9 ? game_no = " #{index + 1}." : game_no = "#{index + 1}." # adjust number column formatting
      puts "#{game_no} #{game.name}:" + (' ' * (max_length - game.name.length + 9)) + "#{game.price}"
    end
  end
  
# promp user for additional action

# take user input and call next method

# return sorted list - aplhabetically
# return sorted list - price
# return sorted list - rating
# return sorted list - by developer alphabetically
# return sorted list - release date



end
