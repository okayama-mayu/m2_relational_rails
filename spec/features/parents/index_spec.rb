require 'rails_helper' 

RSpec.describe 'the parents index page', type: :feature do 
    # User Story 1, Parent Index 
    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
    it 'shows the name of each Menu Section in the system' do 
        section1 = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        section2 = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        section3 = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        section4 = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        section5 = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit '/parents' 
        save_and_open_page

        expect(page).to have_content(section1.name)
        expect(page).to have_content(section2.name)
        expect(page).to have_content(section3.name)
        expect(page).to have_content(section4.name)
        expect(page).to have_content(section5.name)
    end
end