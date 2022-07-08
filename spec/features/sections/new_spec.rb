require 'rails_helper' 

RSpec.describe 'the New Sections page', type: :feature do 
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
    it 'has a form for a new Section record' do 
        Section.destroy_all
        
        visit "/sections/new"
        # save_and_open_page

        expect(current_path).to eq('/sections/new')
        expect(page).to have_content("New Menu Section")
        expect(page).to have_field("Menu Section Name")
        expect(page).to have_field("vegan_options")
        expect(page).to have_field("labor_intensity")
        expect(page).to have_button("Submit")
    end

    it 'has a fillable form' do 
        Section.destroy_all

        visit "/sections/new"
        fill_in :name, with: "Merch"
        page.uncheck(:vegan_options)
        fill_in :labor_intensity, with: "1"
        # save_and_open_page

        expect(current_path).to eq('/sections/new')
        expect(page).to have_field(:name, with: "Merch")
        expect(page).to have_field(:vegan_options, checked: false)
        expect(page).to have_field(:labor_intensity, with: "1")
    end

    it 'can create a new Section and redirect to Section Index with the new Section shown on page' do 
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

        visit "/sections/new"
        fill_in :name, with: "Merch"
        page.uncheck(:vegan_options)
        fill_in :labor_intensity, with: "1"

        click_button("Submit")
        save_and_open_page

        expect(current_path). to eq("/sections")
        expect(page).to have_content("Merch")
    end
end