require 'rails_helper' 

RSpec.describe 'the Section Edit page', type: :feature do 
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
    it 'has a form to edit the Section attributes' do 
        Item.destroy_all
        Section.destroy_all
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)        
        sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
        sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
        sides.items.create!(name: 'Fries', need_restock: false, price: 4)
        sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

        visit "/sections/#{sides.id}"
        click_link("Update This Menu Section")
        save_and_open_page
        
        expect(current_path).to eq("/sections/#{sides.id}/edit")
        expect(page).to have_content("Edit Menu Section")
        expect(page).to have_field("Menu Section Name")
        expect(page).to have_field("vegan_options")
        expect(page).to have_field("labor_intensity")
        expect(page).to have_button("Update Menu Section")
    end
end