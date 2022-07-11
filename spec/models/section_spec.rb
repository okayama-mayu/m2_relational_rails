require 'rails_helper' 

RSpec.describe Section, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name } 
        it { should validate_presence_of :labor_intensity }
        it { should allow_value(true).for(:vegan_options) }
        it { should allow_value(false).for(:vegan_options) }
    end

    it { should have_many :items }    

    describe 'model methods' do 
        describe '#order_by_time_created' do     
            it 'returns @sections with the newest section first and the oldest section last' do 
                phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
                vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
                sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
                drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
                kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)
                sections = Section.all
                
                expect(sections.order_by_time_created.first.name).to eq 'Kids'
                expect(sections.order_by_time_created.last.name).to eq 'Phillys'        
            end
        end

        describe '#total_items' do 
            it 'returns the number of Items associated with a Section' do 
                phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)

                phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
                phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

                expect(phillys.total_items).to eq 2 
            end
        end

        describe '#sort_by_item_count' do 
            it 'returns the Sections by the number of Items they have' do 
                phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
                sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
                vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

                sections = Section.all 

                phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
                phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)

                vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
                vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
                vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

                sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
                sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
                sides.items.create!(name: 'Fries', need_restock: false, price: 4)
                sides.items.create!(name: 'Cheese Fries', need_restock: false, price: 7)

                expect(sections.sort_by_item_count.first).to eq sides
                expect(sections.sort_by_item_count[1]).to eq vegan_phillys
                expect(sections.sort_by_item_count.last).to eq phillys
            end
        end
    end
end