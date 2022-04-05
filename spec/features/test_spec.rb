feature 'test page' do
  it 'test page' do 
  visit '/'
  expect(page).to have_content "This is a test"
  end
end
