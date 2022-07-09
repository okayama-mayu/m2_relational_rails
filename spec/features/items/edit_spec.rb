require 'rails_helper' 

RSpec.describe 'the Item edit page', type: :feature do 
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
    it 'has a form to edit the Item attributes' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)

        visit "/items/#{item.id}/edit" 
        # save_and_open_page

        expect(page).to have_content("Edit Menu Item")
        expect(page).to have_content("Menu Item Name:")
        expect(page).to have_content("Does the menu item or its ingredients need to be restocked? Check if yes.")
        expect(page).to have_content("Menu Item Price: $")
        expect(page).to have_button("Update Item")
    end

    it 'redirects to the Item show page with updated information' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        item = sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)

        visit "/items/#{item.id}/edit" 

        fill_in "Menu Item Name:", with: 'Trillys Famous Pickle Fries'
        click_button("Update Item")
        # save_and_open_page

        expect(current_path).to eq("/items/#{item.id}")
        expect(page).to have_content('Trillys Famous Pickle Fries')
    end
end