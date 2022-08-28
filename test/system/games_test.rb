require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting /new gives us a new random grid of letters" do
    visit new_url
    assert test: "The longest word game"
    assert_selector ("div.letter-box"), count: "10"
  end

  test "fill the form with a random word, click the play button and get a message that the word is a not in the grid" do
    visit new_url
    fill_in 'word', with: 'plouf'
    click_on 'Play!'

    assert_current_path score_path
    assert_text "Sorry, PLOUF can't be build out of #{@letters}"
  end

  test "fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word" do
    visit new_url
    fill_in 'word', with: 't'
    click_on 'Play!'

    assert_current_path score_path
    assert_text "Sorry, T is not an english word"
  end
end
