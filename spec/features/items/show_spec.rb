require 'rails_helper' 

RSpec.describe 'the item show page', type: :feature do 
    # User Story 4, Child Show 
    # As a visitor
    # When I visit '/child_table_name/:id'
    # Then I see the child with that id including the child's attributes:
    it 'shows the Item name, the Menu Section its in, whether it needs a restock, and its price' do
        Item.destroy_all
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

    # User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it 'shows a link to the Item Index at the top of the page' do 
        Item.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)

        visit "/items/#{item1.id}"
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

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items/#{item1.id}"
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

    # User Story 9, Parent Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Parent Index
    it 'shows a link to the Section Index at the top of the page' do
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)

        visit "/items/#{item3.id}"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Menu Sections")
        end
    end

    it 'allows you to navigate to the Section Index if link is clicked' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)

        visit "/items/#{item3.id}"
        click_link "See All Menu Sections"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 14, Child Update 
    # As a visitor
    # When I visit a Child Show page
    # Then I see a link to update that Child "Update Child"
    # When I click the link
    # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
    # When I click the button to submit the form "Update Child"
    # Then a `PATCH` request is sent to '/child_table_name/:id',
    # the child's data is updated,
    # and I am redirected to the Child Show page where I see the Child's updated information
    it 'has a link that takes you to to update Item' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)

        visit "/items/#{item.id}"
        # save_and_open_page
        expect(page).to have_link("Update Item Details")

        click_link("Update Item Details")
        expect(current_path).to eq "/items/#{item.id}/edit" 
    end

    # User Story 20, Child Delete 
    # As a visitor
    # When I visit a child show page
    # Then I see a link to delete the child "Delete Child"
    # When I click the link
    # Then a 'DELETE' request is sent to '/child_table_name/:id',
    # the child is deleted,
    # and I am redirected to the child index page where I no longer see this child
    it 'has a link to delete the Item' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)

        visit "/items/#{item.id}"
        # save_and_open_page

        expect(page).to have_button("Delete Item")
    end

    it 'has a link to delete the Item that if clicked on, will redirect to the item index page where the Item is no longer visible' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item2 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items/#{item.id}"
        click_button "Delete Item" 
        save_and_open_page

        expect(current_path).to eq "/items" 
        expect(page).to_not have_content(item.name)
        expect(page).to have_content(item2.name)
    end
end