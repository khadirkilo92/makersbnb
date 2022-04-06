require_relative '../login_helper.rb'

feature 'test page' do
  it 'test page' do
    test_login
    visit '/'
    expect(page).to have_content "This is a test"
  end
end
