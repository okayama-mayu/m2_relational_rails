require 'rails_helper' 

RSpec.describe 'Section Items index' do 
    # User Story 5, Parent Children Index 
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes:
    it 'shows the Items associated with that Section' do 
        Item.destroy_all
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
        Item.destroy_all
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
        Item.destroy_all
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

    # User Story 9, Parent Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Parent Index
    it 'shows a link to the Section Index at the top of the page' do
        Item.destroy_all
        Section.destroy_all
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        fareast = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        veganphil = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegchicken = vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        visit "/sections/#{vegan_phillys.id}/items"
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

        visit "/sections/#{vegan_phillys.id}/items"
        click_link "See All Menu Sections"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 13, Parent Child Creation 
    # As a visitor
    # When I visit a Parent Childs Index page
    # Then I see a link to add a new adoptable child for that parent "Create Child"
    # When I click the link
    # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
    # When I fill in the form with the child's attributes:
    # And I click the button "Create Child"
    # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
    # a new child object/row is created for that parent,
    # and I am redirected to the Parent Childs Index page where I can see the new child listed
    it 'has a link to add a new Menu Item to the Menu Section' do 
        Item.destroy_all
        Section.destroy_all
        
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)   

        visit "/sections/#{sides.id}/items"
        # save_and_open_page
        
        expect(page).to have_link("Add New Menu Item to Sides Section")

        click_link("Add New Menu Item to #{sides.name} Section")
        expect(current_path).to eq "/sections/#{sides.id}/items/new"
    end

    # User Story 16, Sort Parent's Children in Alphabetical Order by name 
    # As a visitor
    # When I visit the Parent's children Index Page
    # Then I see a link to sort children in alphabetical order
    # When I click on the link
    # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
    it 'has a link to sort Items in alphabetical order' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        vegan_poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        fries = sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        cheese_fries = sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit "/sections/#{sides.id}/items"
        # save_and_open_page

        expect(page).to have_button("Sort Items in Alphabetical Order")
    end

    it 'has a link that takes me to the Menu Section Items Index page' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        vegan_poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        fries = sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        cheese_fries = sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit "/sections/#{sides.id}/items"
        save_and_open_page
        # visit "/sections/#{sides.id}/items?sort=active"
        click_button "Sort Items in Alphabetical Order"
        # save_and_open_page

        expect(current_path).to eq "/sections/#{sides.id}/items"

        within('#item-0') do 
            expect(page).to have_content(cheese_fries.name)
        end

        within('#item-1') do 
            expect(page).to have_content(fries.name)
        end

        within('#item-2') do 
            expect(page).to have_content(pickles.name)
        end

        within('#item-3') do 
            expect(page).to have_content(vegan_poutine.name)
        end
    end

    # User Story 18, Child Update From Childs Index Page 
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    # Next to every child, I see a link to edit that child's info
    # When I click the link
    # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 11
    it 'has a link next to every Item to edit the Item info' do 
        Item.destroy_all
        Section.destroy_all
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

        vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan3 = vegan_phillys.items.create!(name: 'Vegan Seitan Philly', need_restock: true, price: 12)

        visit "/sections/#{vegan_phillys.id}/items" 
        # save_and_open_page

        within('#item-0') do 
            expect(page).to have_button("Edit #{vegan1.name}")
        end

        within('#item-1') do 
            expect(page).to have_button("Edit #{vegan2.name}")
        end

        within('#item-2') do 
            expect(page).to have_button("Edit #{vegan3.name}")
        end
    end

    it 'has a link that takes you to the Item Edit page' do 
        Item.destroy_all
        Section.destroy_all
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

        vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan3 = vegan_phillys.items.create!(name: 'Vegan Seitan Philly', need_restock: true, price: 12)

        visit "/sections/#{vegan_phillys.id}/items"
        click_button "Edit #{vegan1.name}"
        save_and_open_page

        expect(page).to have_content("Edit Menu Item")
        expect(page).to have_content("Menu Item Name:")
        expect(page).to have_content("Does the menu item or its ingredients need to be restocked? Check if yes.")
        expect(page).to have_content("Menu Item Price: $")
        expect(page).to have_button("Update Item")
    end
end