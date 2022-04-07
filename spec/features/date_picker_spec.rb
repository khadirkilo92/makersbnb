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
end 