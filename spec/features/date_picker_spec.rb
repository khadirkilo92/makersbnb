require_relative '../login_helper.rb'

feature 'calendar on the preview page' do
  scenario 'visit the preview page' do
    test_login
    add_test_space
    visit '/spaces'
    first('.item').click_button 'Book Now'
    expect(current_path.split('/')[1]).to eq 'booking_preview'
    expect(page).to have_field 'From Date'
  end 

  scenario 'it has a text box for Number of Nights on the page' do
    test_login
    add_test_space
    visit '/spaces'
    first('.item').click_button 'Book Now'
    expect(current_path.split('/')[1]).to eq 'booking_preview'
    expect(page).to have_field 'Number of Nights'
  end

  scenario 'calculating the default price' do
    test_login
    add_test_space
    visit '/spaces'
    first('.item').click_button 'Book Now'
    expect(current_path.split('/')[1]).to eq 'booking_preview'
    expect(first('.totalprice')).to have_content "300"
  end

  scenario 'filling in Number of Nights and calculating the price' do
    test_login
    add_test_space
    visit '/spaces'
    first('.item').click_button 'Book Now'
    expect(current_path.split('/')[1]).to eq 'booking_preview'
    fill_in "Number of Nights", with: '3'
    expect(first('.totalprice')).to have_content "900"
  end
end 