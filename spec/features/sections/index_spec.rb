require 'rails_helper' 

RSpec.describe 'the parents index page', type: :feature do 
    # User Story 1, Parent Index 
    # For each parent table
    # As a visitor
    # When I visit '/parents'
    # Then I see the name of each parent record in the system
    it 'shows the name of each Menu Section in the system' do 
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        # save_and_open_page

        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 6, Parent Index sorted by Most Recently Created 
    # As a visitor
    # When I visit the parent index,
    # I see that records are ordered by most recently created first
    # And next to each of the records I see when it was created
    it 'orders the Sections by most recently created first' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        # save_and_open_page

        within('#section-0') do 
            expect(page).to have_content("Kids")
        end

        within('#section-1') do 
            expect(page).to have_content("Drinks")
        end

        within('#section-2') do 
            expect(page).to have_content("Sides")
        end

        within('#section-3') do 
            expect(page).to have_content("Vegan Phillys")
        end

        within('#section-4') do 
            expect(page).to have_content("Phillys")
        end
    end

    it 'shows when the Section was created next to each Section' do
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        # save_and_open_page

        within('#section-0b') do 
            expect(page).to have_content(kids.created_at)
        end

        within('#section-1b') do 
            expect(page).to have_content(drinks.created_at)
        end

        within('#section-2b') do 
            expect(page).to have_content(sides.created_at)
        end

        within('#section-3b') do 
            expect(page).to have_content(vegan_phillys.created_at)
        end

        within('#section-4b') do 
            expect(page).to have_content(phillys.created_at)
        end
    end

    # User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it 'shows a link to the Item Index at the top of the page' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Items")
        end
    end

    it 'allows you to navigate to the Item Index if link is clicked' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        item1 = phillys.items.create!(name: 'Steak Philly', need_restock: true, price: 10)

        item2 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

        item3 = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
        item4 = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

        visit "/sections"
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
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        # save_and_open_page

        within('#top-of-page') do
            expect(page).to have_link("See All Menu Sections")
        end
    end

    it 'allows you to navigate to the Section Index if link is clicked' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit "/sections"
        click_link "See All Menu Sections"
        # save_and_open_page

        expect(current_path).to eq('/sections')
        expect(page).to have_content(phillys.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(sides.name)
        expect(page).to have_content(drinks.name)
        expect(page).to have_content(kids.name)
    end

    # User Story 11, Parent Creation 
    # As a visitor
    # When I visit the Parent Index page
    # Then I see a link to create a new Parent record, "New Parent"
    # When I click this link
    # Then I am taken to '/parents/new' where I  see a form for a new parent record
    # When I fill out the form with a new parent's attributes:
    # And I click the button "Create Parent" to submit the form
    # Then a `POST` request is sent to the '/parents' route,
    # a new parent record is created,
    # and I am redirected to the Parent Index page where I see the new Parent displayed.
    it 'has a link to create a new Section' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections"
        # save_and_open_page

        expect(page).to have_link("Create New Menu Section")
    end

    it 'has a link that takes you to a form for a new Section record' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections"
        click_link "Create New Menu Section"
        # save_and_open_page

        expect(current_path).to eq('/sections/new')
        expect(page).to have_content("New Menu Section")
        expect(page).to have_field("Menu Section Name")
        expect(page).to have_field("vegan_options")
        expect(page).to have_field("labor_intensity")
        expect(page).to have_button("Submit")
    end

    # User Story 17, Parent Update From Parent Index Page 
    # As a visitor
    # When I visit the parent index page
    # Next to every parent, I see a link to edit that parent's info
    # When I click the link
    # I should be taken to that parents edit page where I can update its information just like in User Story 4
    it 'has a link next to every Section to edit the Section info' do 
        # Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections"
        # save_and_open_page

        within('#section-0c') do 
            expect(page).to have_button("Edit #{sides.name}")
        end

        within('#section-1c') do 
            expect(page).to have_button("Edit #{vegan_phillys.name}")
        end

        within('#section-2c') do 
            expect(page).to have_button("Edit #{phillys.name}")
        end

        click_button "Edit #{sides.name}"
        # save_and_open_page

        expect(current_path).to eq("/sections/#{sides.id}/edit")
        expect(page).to have_content("Edit Menu Section")
        expect(page).to have_field("Menu Section Name")
        expect(page).to have_field("vegan_options")
        expect(page).to have_field("labor_intensity")
        expect(page).to have_button("Update Menu Section")
    end

    # User Story 22, Parent Delete From Parent Index Page 
    # As a visitor
    # When I visit the parent index page
    # Next to every parent, I see a link to delete that parent
    # When I click the link
    # I am returned to the Parent Index Page where I no longer see that parent
    it 'has a link to delete each Section' do 
        # Item.destroy_all
        # Section.destroy_all 

        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections"
        # save_and_open_page
        # binding.pry 

        within('#section-0c') do 
            expect(page).to have_button("Delete Sides")
        end

        within('#section-1c') do 
            expect(page).to have_button("Delete Vegan Phillys")
        end

        within('#section-2c') do 
            expect(page).to have_button("Delete Phillys")
        end
    end

    it 'deletes a Section with a button and returns to Section Index where the Section is not shown' do 
        # Item.destroy_all
        # Section.destroy_all 

        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections"
        click_button "Delete Sides"
        # save_and_open_page
        # binding.pry 

        expect(current_path).to eq "/sections"
        expect(page).to_not have_content(sides.name)
        expect(page).to have_content(vegan_phillys.name)
        expect(page).to have_content(phillys.name)
    end

    # EXT1: Sort Parents by Number of Children 
    # As a visitor
    # When I visit the Parents Index Page
    # Then I see a link to sort parents by the number of `child_table_name` they have
    # When I click on the link
    # I'm taken back to the Parent Index Page where I see all of the parents in order of their count of `child_table_name` (highest to lowest) And, I see the number of children next to each parent name
    it 'has a link to sort parents by number of Items they have' do 
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit '/sections' 

        expect(page).to have_link("Sort Menu Sections by Number of Items")
    end

    it 'has a link that if clicked goes to the Section index page with the Sections sorted by number of Items' do 
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit '/sections' 
        click_on "Sort Menu Sections by Number of Items"
        # save_and_open_page

        expect(current_path).to eq "/sections"

        within "#section-0" do 
            expect(page).to have_content(sides.name)
        end

        within "#section-1" do 
            expect(page).to have_content(vegan_phillys.name)
        end

        within "#section-2" do 
            expect(page).to have_content(phillys.name)
        end
    end

    it 'has the number of children next to each parent name' do 
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        

        phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
        phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

        vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
        vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
        vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit '/sections' 
        save_and_open_page
        click_on "Sort Menu Sections by Number of Items"
        save_and_open_page

        within "#section-0" do 
            expect(page).to have_content(sides.items.count)
        end

        within "#section-1" do 
            expect(page).to have_content(vegan_phillys.items.count)
        end

        within "#section-2" do 
            expect(page).to have_content(phillys.items.count)
        end
    end
end