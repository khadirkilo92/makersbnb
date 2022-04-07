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
    expect(page).to have_field 'number_of_nights'
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
    fill_in "number_of_nights", with: '3'
    click_button 'Calculate'
    expect(first('.totalprice')).to have_content "900"
  end
end
