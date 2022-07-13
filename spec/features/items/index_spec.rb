require 'rails_helper' 

RSpec.describe 'the child index page', type: :feature do 
    # User Story 3, Child Index 
    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes:
    it 'shows the name of each Menu Item, the Section its in, whether its ingredients need to be restocked, and its price' do 
        Item.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit '/items'
        # save_and_open_page 

        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item4.name)
        expect(page).to have_content(item1.need_restock)
        expect(page).to have_content(item2.price)
        expect(page).to have_content(item3.section.name)
        expect(page).to have_content(item4.need_restock)
    end

    # User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it 'shows a link to the Item Index at the top of the page' do 
        Item.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Items")
        end
    end

    it 'allows you to navigate to the Item Index if link is clicked' do 
        Item.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items"
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
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit '/items'
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

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/items"
        click_link "See All Menu Sections"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 15, Child Index only shows `true` Records 
    # As a visitor
    # When I visit the child index
    # Then I only see records where the boolean column is `true`
    it 'only shows Items that need to be restocked' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

        philly1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        philly2 = phillys.items.create!(name: 'Chicken Philly', need_restock: false, price: 10)

        vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan3 = vegan_phillys.items.create!(name: 'Vegan Seitan Philly', need_restock: true, price: 12)

        visit '/items'
        # save_and_open_page 

        expect(page).to_not have_content(philly1.name)
        expect(page).to_not have_content(philly2.name)
        expect(page).to have_content(vegan1.name)
        expect(page).to have_content(vegan2.name)
        expect(page).to have_content(vegan3.name)       
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
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

        philly1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)
        philly2 = phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan3 = vegan_phillys.items.create!(name: 'Vegan Seitan Philly', need_restock: true, price: 12)

        visit '/items' 
        # save_and_open_page

        within('#section-0') do 
            expect(page).to have_button("Edit #{philly1.name}")
        end

        within('#section-1') do 
            expect(page).to have_button("Edit #{philly2.name}")
        end

        within('#section-2') do 
            expect(page).to have_button("Edit #{vegan1.name}")
        end

        within('#section-3') do 
            expect(page).to have_button("Edit #{vegan2.name}")
        end

        within('#section-4') do 
            expect(page).to have_button("Edit #{vegan3.name}")
        end
    end

    it 'has a link that takes you to the Item Edit page' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)

        visit '/items' 
        click_button "Edit #{item.name}"
        # save_and_open_page

        expect(page).to have_content("Edit Menu Item")
        expect(page).to have_content("Menu Item Name:")
        expect(page).to have_content("Does the menu item or its ingredients need to be restocked? Check if yes.")
        expect(page).to have_content("Menu Item Price: $")
        expect(page).to have_button("Update Item")
    end

    # User Story 23, Child Delete From Childs Index Page 
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    # Next to every child, I see a link to delete that child
    # When I click the link
    # I should be taken to the `child_table_name` index page where I no longer see that child
    it 'has buttons to delete each Item' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)

        visit '/items' 
        # save_and_open_page

        within('#section-0') do
            expect(page).to have_button("Delete Pickle Fries")
        end

        within('#section-1') do
            expect(page).to have_button("Delete Vegan Poutine")
        end

        within('#section-2') do
            expect(page).to have_button("Delete Soda")
        end

        within('#section-3') do
            expect(page).to have_button("Delete Beer")
        end
    end

    it 'has delete buttons that if clicked will redirect to the Items index where the Item is no longer shown' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)

        visit '/items' 
        click_button "Delete Soda" 
        # save_and_open_page

        expect(current_path).to eq '/items'
        expect(page).to_not have_content("Soda")
        expect(page).to have_content(pickles.name)
        expect(page).to have_content(poutine.name)
        expect(page).to have_content(beer.name)
    end

    # Search by name (exact match)
    # As a visitor
    # When I visit an index page ('/parents') or ('/child_table_name')
    # Then I see a text box to filter results by keyword
    # When I type in a keyword that is an exact match of one or more of my records and press the Search button
    # Then I only see records that are an exact match returned on the page
    it 'has a text box to filter results by keywords' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)

        visit '/items' 
        # save_and_open_page

        expect(page).to have_content("Search using key word (exact match):")
    end

    it 'can search for Items using key words with an exact match' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)


        visit '/items' 

        fill_in :search_exact, with: "pickle fries"
        click_button "Search for Exact Match" 
        # save_and_open_page

        expect(page).to have_content("Pickle Fries")
        expect(page).to_not have_content("Vegan Poutine")
        expect(page).to_not have_content("Soda")
        expect(page).to_not have_content("Beer")
    end

    # Search by name (partial match)
    # As a visitor
    # When I visit an index page ('/parents') or ('/child_table_name')
    # Then I see a text box to filter results by keyword
    # When I type in a keyword that is an partial match of one or more of my records and press the Search button
    # Then I only see records that are an partial match returned on the page
    it 'has a text box to filter results by keywords' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)

        visit '/items' 
        # save_and_open_page

        expect(page).to have_content("Search using key word (partial match):")
    end

    it 'can search for Items using key words with a partial match' do 
        Item.destroy_all
        Section.destroy_all

        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

        pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        fries = sides.items.create!(name: 'Fries', need_restock: true, price: 4)
        cheese = sides.items.create!(name: 'Cheese Fries', need_restock: true, price: 7)

        soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
        beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)


        visit '/items' 

        fill_in :search_partial, with: "fries"
        click_button "Search for Partial Match" 
        # save_and_open_page

        expect(page).to have_content(pickles.name)
        expect(page).to have_content(fries.name)
        expect(page).to have_content(cheese.name)

        expect(page).to_not have_content(poutine.name)
        expect(page).to_not have_content(soda.name)
        expect(page).to_not have_content(beer.name)
    end
end