require 'rails_helper' 

RSpec.describe 'New Section Item' do 
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
    it 'has a form for a new Item' do 
        Item.destroy_all
        Section.destroy_all
        
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)   

        visit "/sections/#{sides.id}/items/new"
        # save_and_open_page
        
        expect(page).to have_content("New Menu Item for the Sides Section")
        expect(page).to have_content("Menu Item Name:")
        expect(page).to have_content("Does the menu item or its ingredients need to be restocked? Check if yes.")
        expect(page).to have_content("Menu Item Price: $")
        expect(page).to have_button("Submit")
    end

    it 'can create a new Item and redirect to the Section Items page where the new Item is shown' do 
        Item.destroy_all
        Section.destroy_all
        
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)   

        visit "/sections/#{sides.id}/items/new"

        fill_in :name, with: 'Fries' 
        page.uncheck(:need_restock)
        fill_in :price, with: '4' 

        click_button("Submit") 
        # save_and_open_page

        expect(current_path).to eq("/sections/#{sides.id}/items")
        expect(page).to have_content('Fries')
        expect(page).to have_content('false')
        expect(page).to have_content('$4.00')
    end 
end