require 'rails_helper' 

RSpec.describe 'Section Items index' do 
    # User Story 5, Parent Children Index 
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes:
    it 'shows the Items associated with that Section' do 
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        fareast = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        veganphil = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegchicken = vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)

        visit "/sections/#{vegan_phillys.id}/items"
        # save_and_open_page

        expect(page).to have_content(fareast.name)
        expect(page).to have_content(veganphil.name)
        expect(page).to have_content(vegchicken.name)
        expect(page).to have_content(fareast.need_restock)
        expect(page).to have_content(veganphil.price)
        expect(page).to have_content(vegchicken.need_restock)

        expect(page).to_not have_content(pickles.name)
    end
end