require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end
  def score
    letters = params[:letters].split
    word = params[:word].chars
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    correct_word = JSON.parse(URI.open(url).read)
    is_correct = word.all? { |letter| word.count(letter) <= letters.count(letter) }
    if correct_word["found"] && is_correct
      @score = "Correct! you scored #{correct_word["length"]} points"
    elsif correct_word["found"] == false
      @score = 'Not a word'
    else
      @score = "Word doesn't correspond to the grid"
    end
  end
end
