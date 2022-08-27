require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    consonants = %w[B C D F G H J K L M N P Q R S T V W X Y Z]
    vowels = %w[A E I O U]
    @letters = []
    @score = session[:score]

    6.times do
      @letters << consonants[rand(21)]
    end

    4.times do
      @letters << vowels[rand(5)]
    end
  end

  def score
    @user_input = params["word"].upcase
    @letters = JSON.parse(params["letters"].tr("'", '"'))

    api_results = generate_hash(@user_input)

    @length = @user_input.length

    return @message = "Sorry, #{@user_input} can't be build out of #{@letters.join(", ")}" unless check_input(@user_input, @letters)
    if api_results['found']
      @message =  "Well done! #{@user_input} is a valid English word! You earn #{@length} points"
      session[:score] = calculate_points(@length)
    else
      @message = "Sorry, #{@user_input} is not an English word"
    end
  end

   def reset
    redirect_to('/new')
  end

  private

  def check_input (input, letters)
    input = input.split('')
    array = letters.clone

    input.each do |letter|
      return false unless array.include?(letter)
      array.delete_at(array.index(letter))
    end
    true
  end

  def generate_hash(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    html = URI.open(url).read
    JSON.parse(html)
  end

  def calculate_points(length)
    if session[:score].nil?
      session[:score] = @length
    elsif @length > session[:score]
      session[:score] = @length
    else
      return session[:score]
      total_score
    end

  end

end
