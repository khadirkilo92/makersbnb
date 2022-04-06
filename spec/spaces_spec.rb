require 'space'
require 'pg'
require 'database_helpers'

  describe Space do
    describe '.create' do
      it 'creates a new space' do
        space = Space.create(name: 'Makers Mansion', description: 'Views on the Beach', price_per_night: 1000)
        persisted_data = persisted_data(id: space.id, table: 'spaces')

        expect(space).to be_a Space
        expect(space.id).to eq persisted_data.first['id']
        expect(space.name).to eq 'Makers Mansion'
        expect(space.description).to eq 'Views on the Beach'
      end 
    end 

    describe '.find' do
      it 'finds a space and returns it' do
      space = Space.create(name: 'Makers Mansion', description: 'Views on the Beach', price_per_night: 1000)
      result = Space.find(id: space.id)

      expect(result.id).to eq space.id
      end
  end 
  end 