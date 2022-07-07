require 'rails_helper' 

RSpec.describe 'the item show page', type: :feature do 
    # User Story 4, Child Show 
    # As a visitor
    # When I visit '/child_table_name/:id'
    # Then I see the child with that id including the child's attributes:
    it 'shows the Item name, the Menu Section its in, whether it needs a restock, and its price' do
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items/#{item3.id}"
        # save_and_open_page

        expect(page).to_not have_content(item1.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item3.section.name)
        expect(page).to have_content(item3.need_restock)
        expect(page).to have_content(item3.price)
    end
end