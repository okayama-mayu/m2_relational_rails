require 'rails_helper' 

RSpec.describe Item, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name }
        it { should validate_presence_of :price }

        it { should allow_value(true).for(:need_restock) }
        it { should allow_value(false).for(:need_restock) }
    end
    
    it { should belong_to(:section) }

    describe 'model methods' do 
        describe '#needs_restock_only' do 
            it 'returns @items where the boolean needs_restock is true' do 
                Item.destroy_all
                Section.destroy_all
                phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
                vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)

                philly1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
                philly2 = phillys.items.create!(name: 'Chicken Philly', need_restock: false, price: 10)

                vegan1 = vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
                vegan2 = vegan_phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
                vegan3 = vegan_phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

                items = Item.all

                expect(items.needs_restock_only.count).to eq 3 
                expect(items.needs_restock_only).to include(vegan1)
                expect(items.needs_restock_only).to include(vegan2)
                expect(items.needs_restock_only).to include(vegan3)
                expect(items.needs_restock_only).not_to include(philly1)
                expect(items.needs_restock_only).not_to include(philly2)
            end
        end
    end
end