# Steam Roller Readme

#Overview
This program is intended to scan the Steam Games webpage and return the list of top games and their info to inspect. The program can look at either the top selling list of games or the newest releases. At the time of programming the list returns 15 games per list, but the program can adjust for any length list if the Steam Games pages are to ever change.

The advantage to this program is bypassing the graphics & image heavy webpage. This is able to look up the info needed much quicker by simply scraping text data.

When the user first starts the program, they select which list they would like to look at, the program then reaches out and scrapes the website to pull the info down. After the list is returned to the user they can then select to see a specific game in more detail or select from more options to sort the list in different ways. The first pass pulls only basic info available on the list page, including name, rank, price, and html link to it's direct page. when the user selects a game to see in more detail, a second scrape is performed on that game's specific webpage. This strategy avoids a significant amount of potentially unnecessary work by the program to look at 15 game pages every run. The only time all pages are searched is when sorting by an attribute that is not yet gathered from the list page(publisher, release date, genre, tags, etc.)

After the user selects a game to view in detail, they are presented the list of info, and then prompted for the next action, which is to start over with a new search, list a different game, or sort the list in a different way.

One limitation to this program is that it cannot display detailed info on mature rated games. The Steam required an age validation that cannot be passed with this implementation of Nokogiri.

SteamRoller makes use of the following classes:
  -'Game' class to store the game instances
  -'Scraper' class to scrape the info from websites
  -'CLI' class to run and execute the program

# Installation Instructions
Code can be cloned from the following GitHub repository:
https://github.com/kingsley113/steam_roller_cli_app.git
The bin and lib directories with class definitions are required.
To run this CLI program, the following gems are required:
  -Nokogiri
  -Colorize

# User Instructions
  1. start the program by running the bin/steamroller.rb file
  2. user is greeted and then prompted to enter 1 or 2 for which game list to review
  3. Corresponding game list is then scraped, returned and displayed.
  4. Enter a number between 1 & 15 then 'return' to select a corresponding game
  5. Enter 'more' to see additional options to perform with the list.
  6. if a game is selected, program will then display that game's detailed info, and then prompt for additional actions
  7. if 'more' is selected, program will display a list of several sort options:
    -"Sort List by x" - program will sort the current game list by "x" attribute
    -"Start Over" - program will reset the game instances and start at the beginning to select the game list
    -"Exit" - exits the program

# License
  MIT open source license, Copyright 2021 Cameron Kingsley
