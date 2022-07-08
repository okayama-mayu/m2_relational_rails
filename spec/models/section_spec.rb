require 'rails_helper' 

RSpec.describe Section, type: :model do 
    describe 'data validations' do 
        it { should validate_presence_of :name } 
        it { should validate_presence_of :labor_intensity }
        it { should allow_value(true).for(:vegan_options) }
        it { should allow_value(false).for(:vegan_options) }
    end

    it { should have_many :items }    

    describe 'instance methods' do 
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
    end
end