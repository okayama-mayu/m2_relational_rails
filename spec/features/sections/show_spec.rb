require 'rails_helper' 

RSpec.describe 'the section show page', type: :feature do 
    # User Story 2, Parent Show 
    # As a visitor
    # When I visit '/parents/:id'
    # Then I see the parent with that id including the parent's attributes:
    # - data from each column that is on the parent table
    it 'shows the sections name, whether it has vegan options, and the level of labor intensity required' do 
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        visit "/sections/#{phillys.id}"
        # save_and_open_page

        expect(page).to have_content(phillys.name)
        expect(page).to have_content(phillys.vegan_options)
        expect(page).to have_content(phillys.labor_intensity)
    end

    # User Story 7, Parent Child Count
    # As a visitor
    # When I visit a parent's show page
    # I see a count of the number of children associated with this parent
    it 'shows the count of number of Items associated Section' do 
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        visit "/sections/#{phillys.id}"
        save_and_open_page
        
        expect(page).to have_content("Items in Section: #{phillys.items.count}")
    end
end