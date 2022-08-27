class GamesController < ApplicationController
  def new
    consonants = %w[B C D F G H J K L M N P Q R S T V W X Y Z]
    vowels = %w[A E I O U]
    @letters = []

    6.times do
      @letters << consonants[rand(21)]
    end

    4.times do
      @letters << vowels[rand(5)]
    end
  end

  def score

  end
end
