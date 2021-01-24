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
    secondary_input = get_next_input
    display_game_info
  end

# welcome user, prompt for which Steam list to access
  def welcome_user
    puts "----------------------------------------------------------------------------".colorize(:yellow)
    puts "Welcome to the Steam Roller! The quickest way to access the top Steam games!".colorize(:yellow)
    puts "----------------------------------------------------------------------------".colorize(:yellow)
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
      puts "Invalid entry, please try again.".colorize(:red)
      get_first_input
    end

    user_input
  end

# create the game objects from user selection
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

    # output the list header
    header_width = max_length + 20
    puts "\n" + ('-' * header_width)
    puts "#{@selected_list}".center(max_length + 20, " ")
    puts ('-' * (max_length + 20))

    # output the list details, iterate over each instance to print game list
    Game.all.each_with_index do |game, index|
      puts "#{index + 1}.".rjust(3) + " #{game.name}:" + (' ' * (max_length - game.name.length + 9)) + "#{game.price}"
      game.list_no = index + 1
    end
    puts ('-' * header_width)
  end

# promp user for additional action
  def get_next_input
    puts "\nSelect game to see more details. (enter 1-15)"
    puts "For more options, enter 'more'"
    user_input = gets.chomp
    if user_input.to_i.between?(1, 15)        # check for game entry
      user_input
    elsif user_input.downcase == "more"       # check for 'more' entry
      puts "more options!!!"
      user_input = 0
    else
      puts "Invalid entry, please try again." # check for other invalid entry
      get_next_input
    end
    user_input
  end

# take user input and call next method

# display detailed game info based off of the selected game
  def display_game_info(game_list_no)
    binding.pry
  end
# return sorted list - aplhabetically
# return sorted list - price
# return sorted list - rating
# return sorted list - by developer alphabetically
# return sorted list - release date



end
