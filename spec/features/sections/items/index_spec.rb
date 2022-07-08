require 'rails_helper' 

RSpec.describe 'Section Items index' do 
    # User Story 5, Parent Children Index 
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes:
    it 'shows the Items associated with that Section' do 
        Section.destroy_all
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

    # User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it 'shows a link to the Item Index at the top of the page' do 
        Section.destroy_all
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

        fareast = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        veganphil = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegchicken = vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        visit "/sections/#{vegan_phillys.id}/items"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Items")
        end
    end

    it 'allows you to navigate to the Item Index if link is clicked' do 
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/sections/#{vegan_phillys.id}/items"
        click_link "See All Items"
        # save_and_open_page

        expect(current_path).to eq('/items')
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item4.name)
        expect(page).to have_content(item1.need_restock)
        expect(page).to have_content(item2.price)
        expect(page).to have_content(item3.section.name)
        expect(page).to have_content(item4.need_restock)
    end
end