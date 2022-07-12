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
        
        describe '#alpha_sort' do 
            it 'sorts the items in alphabetical order' do 
                Item.destroy_all
                Section.destroy_all

                sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)

                pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
                vegan_poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)
                fries = sides.items.create!(name: 'Fries', need_restock: true, price: 4)
                cheese_fries = sides.items.create!(name: 'Cheese Fries', need_restock: true, price: 7)

                expect(sides.items.alpha_sort.first).to eq cheese_fries
                expect(sides.items.alpha_sort[1]).to eq fries 
                expect(sides.items.alpha_sort[2]).to eq pickles
                expect(sides.items.alpha_sort.last).to eq vegan_poutine                 
            end
        end

        describe '#min_filter' do 
            it 'returns Items whose prices are greater than or equal to the paramter' do 
                Item.destroy_all
                Section.destroy_all
                phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
                item1 = phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)
                item2 = phillys.items.create!(name: 'Chicken Philly', need_restock: true, price: 10)
                item3 = phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)
                item4 = phillys.items.create!(name: 'Vegan Philly', need_restock: true, price: 12)
                item5 = phillys.items.create!(name: 'Vegan Chicken Philly', need_restock: true, price: 12)

                items = Item.all 

                expect(items.min_filter("12").count).to eq 3 
                expect(items.min_filter("12").first).to eq item3 
                expect(items.min_filter("12")[1]).to eq item4
                expect(items.min_filter("12").last).to eq item5
            end
        end

        describe '#search' do
            it 'can return an Item based on a search' do
                Item.destroy_all
                Section.destroy_all 

                sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
                drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)

                pickles = sides.items.create!(name: 'Pickle Fries', need_restock: true, price: 6)
                poutine = sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)

                soda = drinks.items.create!(name: 'Soda', need_restock: true, price: 3)
                beer = drinks.items.create!(name: 'Beer', need_restock: true, price: 5)

                expect(Item.search("Pickle Fries")).to eq [pickles]
                expect(Item.search("vegan poutine")).to eq [poutine] 
                expect(Item.search("soDa")).to eq [soda] 
                expect(Item.search("BEER")).to eq [beer] 
            end
        end
    end
end