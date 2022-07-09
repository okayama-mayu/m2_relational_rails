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

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
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

    # User Story 12, Parent Update 
    # As a visitor
    # When I visit a parent show page
    # Then I see a link to update the parent "Update Parent"
    # When I click the link "Update Parent"
    # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
    # When I fill out the form with updated information
    # And I click the button to submit the form
    # Then a `PATCH` request is sent to '/parents/:id',
    # the parent's info is updated,
    # and I am redirected to the Parent's Show page where I see the parent's updated info
    it 'has a link to Update Section' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)        
        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit "/sections/#{sides.id}"
        # save_and_open_page

        expect(page).to have_link("Update This Menu Section")
    end

    it 'has a link that leads to the Section Edit page' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)        
        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit "/sections/#{sides.id}"
        click_link("Update This Menu Section")

        expect(current_path).to eq("/sections/#{sides.id}/edit")
    end

    # User Story 19, Parent Delete 
    # As a visitor
    # When I visit a parent show page
    # Then I see a link to delete the parent
    # When I click the link "Delete Parent"
    # Then a 'DELETE' request is sent to '/parents/:id',
    # the parent is deleted, and all child records are deleted
    # and I am redirected to the parent index page where I no longer see this parent
    it 'has a button to delete Section' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections/#{vegan_phillys.id}"
        # save_and_open_page

        expect(page).to have_button("Delete This Menu Section")
    end

    it 'has a button to delete Section, and clicking on the button redirects to the parent index page where the deleted Section is no longer visible' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections/#{vegan_phillys.id}"
        click_button "Delete This Menu Section"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to_not have_content(vegan_phillys.name)
    end

    it 'has a button to delete Section, and clicking on the button deletes all associated Items' do 
        Item.destroy_all
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan3 = vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        visit "/items"

        expect(page).to have_content(vegan1.name)
        expect(page).to have_content(vegan2.name)
        expect(page).to have_content(vegan3.name)

        visit "/sections/#{vegan_phillys.id}"
        click_button "Delete This Menu Section"
        visit "/items"

        expect(page).to_not have_content(vegan1.name)
        expect(page).to_not have_content(vegan2.name)
        expect(page).to_not have_content(vegan3.name)
    end
end