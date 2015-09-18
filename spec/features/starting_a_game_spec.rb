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
    expect(page).to have_css("div[style='height:40px; width:40px; background-color:#FF0000; border:1px solid white; border-radius: 20px; display: inline-block']", count: 2)
    expect(page).to have_css("div[style='height:40px; width:40px; background-color:#DFDF5E; border:1px solid white; border-radius: 20px; display: inline-block']", count: 2)
    expect(page).to have_css("div[style='height:40px; width:40px; background-color:#009933; border:1px solid white; border-radius: 20px; display: inline-block']", count: 5)
    expect(page).to have_css("div[style='height:40px; width:40px; background-color:#0099FF; border:1px solid white; border-radius: 20px; display: inline-block']", count: 91)
  end

end
