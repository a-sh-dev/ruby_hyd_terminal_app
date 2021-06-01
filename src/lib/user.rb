require 'colorize'
require 'rainbow'
require 'tty-prompt'
require 'tty-spinner'

require_relative 'methods'
require_relative 'log'

class User
  attr_reader :user_cap, :log_today, :log_array
  attr_accessor :user

  def initialize(name_input)
    @user = name_input
    @user_cap = @user.capitalize.light_yellow.bold
    @file_path = "./data/users/#{@user}.json"
    @prompt = TTY::Prompt.new(active_color: :yellow)
    @log = Log.new
    @log_today = @log.user_today
    @log_array = []
    # @log_array = self.load_entries_to_array    
  end

  def check_system
    # Existing user?
    if existing_user
      display_app_header
      puts "  Welcome back, #{@user_cap}!"
      puts "  Glad to see you again!"
      linebreak
    else # Create new user
      new_user
      display_app_header
      puts "  Glad that you're here, #{@user_cap}!"
      linebreak
      wait
      puts "  Every time you use this app, a log is created and is only accessible by you"
      puts "  to check on how you doin. So, when you use the app next time, please make sure"
      puts "  to remember the name ⟾  #{@user_cap} that you've entered to login!"
      linebreak
      wait_longer
      wait_abit
    end
  end

  def ask_feeling
    wait_abit
    puts "  So, how you doin (feeling) right now, #{@user_cap}?"
    linebreak
  end

  # Connect with Log to ask (feeling) f_before and f_after
  def log_include(f_cond)

    collected_input = @prompt.collect do
      key(f_cond.to_sym).select("  Right now, I feel:", %w(Bored Average Happy Anxious Sad Stress), cycle: true)
    end

    # Back-end - update user_today log
    @log_today = @log_today.merge(collected_input)

  end

  # Respond to Feeling :BEFORE
  def check_alert_fbefore
    alert = ["Sad", "Stress", "Anxious"]
    user_alert = @log_today[:f_before]
    # compare user's input with 'alert' to respond    
    if alert.count(user_alert) == 1
      respond_alert_fbefore
    else
      respond_normal_fbefore
    end
  end
  
  # Respond to Feeling :AFTER - if yes call mhealth
  def check_alert_fafter
    alert = ["Sad", "Stress", "Anxious"]
    user_alert = @log_today[:f_after]
    # compare user's input with 'alert' to respond    
    if alert.count(user_alert) == 1
      # respond_alert_fbefore
      puts "  ======== ALERT: DISPLAY MHEALTH INFO"
    else
      # respond_normal_fbefore
      puts "  ======== NORMAL CHECKING OK!"
    end

    puts "  === CHECKING LOG : user.rb --> for username: #{@user_cap} ==="
    puts "  === SHOWING @log_today before being saved ===="
    puts "  --- #{@log_today}" 
    puts

    save_today_entry
    # DEBUGGING
    # load_entries_to_array
    puts "  === SHOWING @log_array after being merged with @log_today ===="
    display_test = @log_array.each do |set|
      puts "  --> #{set}"        
    end
    puts "  === #{@log_array}"
    # display_entries
  end

  def display_entries
    @log_array.each_with_index do |index, entry|
      puts "  #{index +1}. #{entry[:date]} | Feelings (before): #{entry[:f_before]} | Feelings (after): #{entry[:f_after]}"
      puts "  ----------- END OF DISPLAY -------------"
    end
    # call @log_table - nice format view
  end

  # !! PROBLEM HERE -- CAN'T SEEM TO LOAD EXISTING DATA FROM .JSON FILE TO AN ARRAY
  # !! AT THE END IT KEPT RE-WRITING THE FILE....
  # Add today's @user_today entry to json
  def save_today_entry
    # load data first into an array > methods.rb
    @log_array = self.json_data_to_array(@file_path, @log_array)
    # unless File.zero?(@file_path)
    #   json_data_to_array(@file_path, @log_array)
    # end
    # merge
    # temp_array = @log_today
    # @log_array << temp_array
    # save all entries to json
    File.write(@file_path, @log_array.to_json)
  end

  # Load all user's recorded entries to @log_array
  # def load_entries_to_array
  #   json_file = JSON.parse(File.read(@file_path))
  #   @log_array = json_file.map do |entry|
  #     entry.transform_keys(&:to_sym)
  #   end
  # rescue Errno::ENOENT
  #   File.open(user_file_path, 'w+')
  #   File.write(user_file_path, [])
  #   retry
  # end

  # Exit message
  def bye
    linebreak
    puts "  Thank you for using the HYD app."
    puts "  See you next time, #{@user_cap}! Please take care!"
    linebreak
    puts "  For further info, please check the documentation."
    by_ash = "  Crafted with ❤ by a-sh. © 2021"
    puts Rainbow(by_ash).color("8DEEA6")
  end
  
  private

  def existing_user
    File.exist?(@file_path)
  end

  def new_user
    file = File.new(@file_path, 'w')
    file.close
  end

  # if user's feeling in the alert / concern category
  def respond_alert_fbefore
    linebreak
    wait
    puts "  " + green_up(":-(") + "  That must be really hard for you, #{@user_cap}."
    wait_long
    puts "  It's OK to be not OK."
    linebreak
    wait
    puts "  You've recognised how you're feeling today, and that's a good start!"
    puts "  Take your time to process it and hopefully you will feel better soon!"
    linebreak
    wait_longer
    puts "  Now, lets get ready for an entertainment!"
    linebreak
  end

  def respond_normal_fbefore
    linebreak
    wait
    puts "  Then let's get ready for an entertainment, #{@user_cap}!"
    linebreak
  end

end