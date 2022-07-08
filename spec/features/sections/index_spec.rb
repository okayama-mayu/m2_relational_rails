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

        visit '/sections' 
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
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit '/sections' 
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
        Section.destroy_all
        phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
        kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

        visit '/sections'
        save_and_open_page

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
end