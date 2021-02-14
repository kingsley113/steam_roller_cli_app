require_relative "../lib/developer.rb"
require_relative "../lib/game.rb"
require_relative "../lib/scraper.rb"
require "nokogiri"
require "colorize"
require 'pry'

class CommandLineInterface
# establish attributes
  attr_accessor :selected_list, :game_list_size, :header_width, :header_color

def initialize
  @header_width = 80
  @header_color = :yellow
end

# run ------------------------------------------------------
  def run
    welcome_user
    user_list_selection = get_first_input

    if user_list_selection == 1
      game_array = Scraper.new.scrape_new_release_page
      make_game_objects(game_array)
      @selected_list = "NEW RELEASES:"
    elsif user_list_selection == 2
      game_array = Scraper.new.scrape_top_sellers_page
      make_game_objects(game_array)
      @selected_list = "TOP SELLERS:"
    end
    display_game_list

    # start second round of actions - this will repeat until user exits
    secondary_input = get_next_input
    secondary_action(secondary_input)

  end
# run ------------------------------------------------------


# welcome user, prompt for which Steam list to access
  def welcome_user
    line_break
    # puts "Welcome to the Steam Roller! The quickest way to access the top Steam games!".center(@header_width).colorize(@header_color)
    puts "WELCOME TO THE STEAM ROLLER! THE QUICKEST WAY TO ACCESS THE TOP STEAM GAMES!".center(@header_width).colorize(@header_color)
    line_break
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
    # name_length = []
    # Game.all.each do |game|
      # name_length << game.name.length
    # end
    # max_length = name_length.max

    # output the list header
    # @header_width = max_length + 20
    line_break
    puts "#{@selected_list}".center(@header_width).colorize(@header_color)
    # puts "#{@selected_list}".center(max_length + 20, " ")
    line_break

    # output the list details, iterate over each instance to print game list
    Game.all.each_with_index do |game, index|
      puts "#{index + 1}.".rjust(3) + " #{game.name}:" + ('.' * (@header_width - game.name.length - 5 - game.price.length)) + "#{game.price}"
      game.list_no = index + 1
      @game_list_size = index + 1
    end
    line_break
  end


# promp user for additional action
  def get_next_input
    puts "\nSelect game to see more details. (enter 1-15)"
    puts "For more options, enter 'more'"
    user_input = gets.chomp
    if user_input.to_i.between?(1, @game_list_size)   # check for game entry
      user_input.to_i
    elsif user_input.downcase == "more"               # check for 'more' entry
      user_input = 0
    else
      puts "Invalid entry, please try again." # check for other invalid entry
      get_next_input
    end

  end


# take user input and call next method
  def secondary_action(user_input)
    if user_input.between?(1, @game_list_size)
      selected_game = Game.all.find{|game| game.list_no == user_input}
      # add in the mising detailed game info
      selected_game.add_missing_info
      # display the game details
      display_game_info(selected_game)
    elsif user_input == 0
      more_actions(get_input_more_options)
      #TODO display other options here
    end
    #TODO make sure this repeats until user exits
  end


# display detailed game info based off of the selected game
  def display_game_info(game)
    # display header
    line_break
    puts "Game Info".center(@header_width).colorize(@header_color)
    line_break
    #display game info lines
    # game title
    puts "Title:".rjust(13) + " #{game.name}"
    # list number "#X top seller" etc.
    puts "Rank:".rjust(13) + " ##{game.list_no} #{@selected_list.chop.chop}"
    # price
    puts "Price:".rjust(13) + " #{game.price}"
    # rating
    puts "Rating:".rjust(13) + " #{game.rating}"
    # release date
    puts "Release Date:".rjust(13) + " #{game.release_date}"
    # developer
    puts "Developer:".rjust(13) + " #{game.developer}"
    # tags
      print "User Tags:".rjust(13) + " "
      if game.tags != "Not Available"
        game.tags.each_with_index do |tag, index|
          if index == 0
            print "#{tag}"
          else
            print ", #{tag}"
          end
        end
      else
        print "Not Available"
      end
    puts "\n"

    line_break
  end


# method to get user to select additional options, checks if it is a valid input
  def get_input_more_options
    line_break
    puts "MORE OPTIONS:".center(@header_width).colorize(@header_color)
    line_break

    puts "1. Sort List by Names"
    puts "2. Sort List by Price"
    puts "3. Sort List by Developer"
    puts "4. Sort List by Release Date"
    puts "5. Start Over"
    puts "6. Exit"
    puts ("~" * @header_width).colorize(@header_color)
    puts "Please enter 1-6 to continue:"
    user_input = gets.to_i

    if !user_input.between?(1,6) # check for valid input
      puts "Invalid Entry, try again.".colorize(:red)
      get_input_more_options
    end

    user_input
  end


  def more_actions(input)
    if input.between?(1,4)
      puts "this will send the input to the corresponding list sorting method"
      sort_game_list(input)
    elsif input == 5 #start over and clear the instances
      start_over
    elsif input == 6 #exits the program
      puts "Bye! Come back soon!"
      puts " BBBBBB     YY    YY     EEEEEEE  !!"
      puts " BB   BB      YY YY      EE       !!"
      puts " BBBBB         YYY       EEEEE    !!"
      puts " BB   BB       YY        EE"
      puts " BBBBBB       YY         EEEEEEE  !!"
      exit
    end
  end


# return sorted list - aplhabetically
# return sorted list - price
# return sorted list - rating
# return sorted list - by developer alphabetically
# return sorted list - release date

  def sort_game_list(input)
    sorted_list = []
    if input == 1
      # sort list alphabetically by name
      sorted_list = #Game.sort_by_name
      puts "sort the list by name"
    elsif input == 2
      # sort list by price
      sorted_list = #Game.sort_by_price
      puts "sort the list by price"
    elsif input == 3
      # sort list by developer
      sorted_list = #Game.sort_by_developer
      puts "sort the list by developer"
    elsif input == 4
      # sort list by release date
      sorted_list = #Game.sort_by_release_date
      puts "sort the list by release date"
    end
    display_sorted_game_list(sorted_list)
  end

  def display_sorted_game_list(list_array)
  end



# line break method to clean up code
  def line_break
    puts ("~" * @header_width).colorize(@header_color)
  end


# start the program over and clear the game instances so they do not stack up
  def start_over
    Game.reset_all
    run
  end

end
