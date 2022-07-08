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
        # save_and_open_page
        
        expect(page).to have_content("Items in Section: #{phillys.items.count}")
    end

    # User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it 'shows a link to the Item Index at the top of the page' do 
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        visit "/sections/#{phillys.id}"
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

        visit "/sections/#{phillys.id}"
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
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        visit "/sections/#{phillys.id}"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Menu Sections")
        end
    end

    it 'allows you to navigate to the Section Index if link is clicked' do 
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections/#{phillys.id}"
        click_link "See All Menu Sections"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 10, Parent Child Index Link
    # As a visitor
    # When I visit a parent show page ('/parents/:id')
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    it 'shows the link to the Sections Items page' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        item2= phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        visit "/sections/#{phillys.id}"
        # save_and_open_page
        
        expect(page).to have_link("See All Items in this Menu Section")
    end

    it 'allows you to navigate to the Section Items page if link is clicked' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        item2= phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        visit "/sections/#{phillys.id}"
        click_link "See All Items in this Menu Section"
        # save_and_open_page
        
        expect(current_path).to eq("/sections/#{phillys.id}/items")
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item1.need_restock)
        expect(page).to have_content(item2.price)
    end
end