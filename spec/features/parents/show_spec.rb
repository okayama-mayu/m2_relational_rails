require 'rails_helper' 

RSpec.describe 'the section show page', type: :feature do 
    # User Story 2, Parent Show 
    # As a visitor
    # When I visit '/parents/:id'
    # Then I see the parent with that id including the parent's attributes:
    # - data from each column that is on the parent table
    it 'shows the sections name, whether it has vegan options, and the level of labor intensity required' do 
        section1 = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        visit "/parents/#{section1.id}"

        expect(page).to have_content(section1.name)
        expect(page).to have_content(section1.vegan_options)
        expect(page).to have_content(section1.labor_intensity)
    end
end