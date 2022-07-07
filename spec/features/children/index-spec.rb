require 'rails_helper' 

RSpec.describe 'the child index page', type: :feature do 
    # User Story 3, Child Index 
    # As a visitor
    # When I visit '/child_table_name'
    # Then I see each Child in the system including the Child's attributes:
    it 'shows the name of each Menu Item, the Section its in, whether its ingredients need to be restocked, and its price' do 
        section1 = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
        section2 = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
        section3 = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
        
        item1 = Item.create!(name: 'Steak Philly', need_restock: false, price: 10, section_id: section1.id)
        item2 = Item.create!(name: 'Vegan Far East', need_restock: true, price: 15, section_id: section2.id)
        item3 = Item.create!(name: 'Pickle Fries', need_restock: false, price: 6, section_id: section3.id)
        item4 = Item.create!(name: 'Vegan Poutine', need_restock: true, price: 10, section_id: section3.id)

        visit '/child_table_name'
        save_and_open_page 

        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item3.name)
        expect(page).to have_content(item4.name)
        expect(page).to have_content(item1.need_restock)
        expect(page).to have_content(item2.price)
        expect(page).to have_content(item3.section_id)
        expect(page).to have_content(item4.need_restock)
    end
end