require 'spec_helper'

feature 'Starting a new game' do
  scenario 'visiting the homepage that says Welcome to Battleships' do
    visit '/'
    expect(page).to have_content 'Welcome to Battleships!'
  end

  scenario 'homepage asks for name in form and submit button takes you to next page' do
    visit '/'
    fill_in('player_name', :with => 'Alex')
    click_button 'New Game'
    expect(page).to have_content "Alex's game:"
  end

  scenario 'a test page that has a grid with ships and water in other cells' do
    visit '/test-page'
    expect(page).to have_css("div", count: 100)
  end
end
