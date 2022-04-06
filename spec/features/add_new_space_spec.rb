require_relative '../login_helper.rb'

feature " new space" do
    scenario "user adds a new space " do
      test_login
        visit ('/new-space')
        fill_in 'name', with: 'Makers Mansion'
        fill_in 'description', with: 'Great location for vacation'
        fill_in 'price_per_night', with: '100'
        click_button 'submit'
        result = DatabaseConnection.query(
            'SELECT * FROM spaces;'
        )
        result.map {|i| {
            'name' => i['name'],
            'description' => i['description'],
            'price_per_night' => i['price_per_night'],
        } }
        expect(result[0]['name']).to eq 'Makers Mansion'

    end
end
