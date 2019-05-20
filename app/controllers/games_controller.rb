require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    @result = params[:word]
    test(@result, params[:letters])
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def test(guess, grid)
    if included?(guess, grid)
      if english_word?(guess)
        @score = guess.chars.length
      else
        @scoure = 0
      end
    else
      @score = 0
    end
  end
end
